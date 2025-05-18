import os
import re
import subprocess
import csv
import platform
import numpy as np

# Constants for case identifiers
CASE0 = "case_0"
CASE1 = "case_1"
CASE2 = "case_2"

class TinyMcRunner:
    def __init__(self, case, n_runs, compiler="gcc", photons=32, n_threads=8, output_dir='./results'):
        self.case = case
        self.exe = f"./{case}"
        self.n_runs = n_runs
        self.compiler = compiler
        self.photons = photons
        self.n_threads = n_threads
        self.device = "local-pc" if "adolfo" in platform.node() else platform.node()
        self.output_dir = output_dir
        self.outfile = self._generate_outfile_name()

        # Ensure the output directory exists
        os.makedirs(self.output_dir, exist_ok=True)

    def _generate_outfile_name(self):
        base_filename = f"{self.case}_{self.compiler}_{self.device}_{self.photons}K"
        if self.case == CASE2:
            base_filename += f"_{self.n_threads}Th"
        return os.path.join(self.output_dir, base_filename + ".txt")

    def compile(self):
        subprocess.run(["make", "clean"], check=True)
        subprocess.run(
            ["make", f"CC={self.compiler}", self.case, f"PHOTONS={self.photons * 1024}", f"N_THREADS={self.n_threads}"],
            check=True
        )

    def run(self):
        try:
            with open(self.outfile, "w") as outfile:
                process = subprocess.run(
                    ["perf", "stat", "-r", str(self.n_runs), self.exe],
                    stdout=outfile, stderr=subprocess.PIPE, text=True, check=True
                )
                print(process.stderr)
        except subprocess.CalledProcessError as e:
            print(f"Error executing perf: {e}")

    def save_results(self):
        with open(self.outfile, "r") as f:
            data = f.read()

        runs_data = re.split(r"(# extra\s+[\d.e+-]+)", data)
        results = []

        for i in range(0, len(runs_data) - 1, 2):
            photons_match = re.search(r"Photons\s+=\s+(\d+)", runs_data[i])
            time_match = re.search(r"(\d+\.\d+) seconds", runs_data[i])
            photons_per_second_match = re.search(r"(\d+\.\d+) K photons per second", runs_data[i])

            if photons_match and time_match and photons_per_second_match:
                results.append({
                    "photons": int(photons_match.group(1)),
                    "time": float(time_match.group(1)),
                    "photons_per_second": float(photons_per_second_match.group(1))
                })

        csv_filename = self.outfile.replace('.txt', '.csv', 1)
        with open(csv_filename, "w", newline="") as f:
            writer = csv.DictWriter(f, fieldnames=["photons", "time", "photons_per_second"])
            writer.writeheader()
            writer.writerows(results)

# Function to run tests for both strong and weak scaling
def execute_tests(scaling_type, output_dir='./results'):
    cores = os.cpu_count()

    for i in range(2, 3):
        for compiler in ["gcc", "icx"]:
            if scaling_type == "strong":
                for photons in [512, 1024, 4096]:
                    case = f"case_{i}"
                    if case != CASE2:
                        runner = TinyMcRunner(case, 50, compiler=compiler, photons=photons, output_dir=output_dir)
                        runner.compile()
                        runner.run()
                        runner.save_results()
                    else:    
                        for n_threads in np.unique(np.linspace(1, cores, 8, dtype=int)):
                            runner = TinyMcRunner(case, 30, compiler=compiler, photons=photons, n_threads=n_threads, output_dir=output_dir)
                            runner.compile()
                            runner.run()
                            runner.save_results()
                            
            elif scaling_type == "weak":
                case = CASE2
                base_photons = 512
                for n_threads in np.unique(np.linspace(1, cores, 8, dtype=int)):
                    photons = base_photons * n_threads
                    runner = TinyMcRunner(case, 30, compiler=compiler, photons=photons, n_threads=n_threads, output_dir=output_dir)
                    runner.compile()
                    runner.run()
                    runner.save_results()
            else:
                raise ValueError("Invalid scaling type. Choose 'strong' or 'weak'.")

if __name__ == "__main__":
    # Example usage: Running tests for weak scaling with a custom output directory
    tests = ["weak","strong"]
    for test in tests:
        execute_tests(test, output_dir=f"./results/case_2_{test}_scaling")
