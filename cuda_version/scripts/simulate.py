"""  
Script to profile CUDA version of monte carlo photon simulation.

Performs weak scaling and strong scaling test of the simulation code.
Saves te results into .csv files. and plots the results using matplotlib.
"""
import os
import re
import subprocess
import csv
import platform
import numpy as np

class TinyMcRunner:
    def __init__(self, case, n_runs, photons=32, thr_per_block=32, output_dir='./results'):
        self.case = case
        self.exe = f"../tiny_mc"
        self.n_runs = n_runs
        self.photons = photons
        self.n_threads = thr_per_block
        self.device = "local-pc" if "adolfo" in platform.node() else platform.node()
        self.output_dir = output_dir
        self.outfile = self._generate_outfile_name()

        # Ensure the output directory exists
        os.makedirs(self.output_dir, exist_ok=True)

    def _generate_outfile_name(self):
        base_filename = f"{self.case}_{self.device}_{self.photons}K_{self.n_threads}Tpb"
        return os.path.join(self.output_dir, base_filename + ".txt")

    def compile(self):
        subprocess.run(["make", "clean"], check=True, cwd="..")
        subprocess.run(
            ["make", f"PHOTONS={self.photons * 1024}", f"N_THREADS={self.n_threads}"],
            check=True, cwd=".."
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
        """
        Parses the output file and saves the results into a CSV file with columns:
        photons,photons_per_second
        """
        with open(self.outfile, "r") as f:
            data = f.read()
        photons_match = re.search(r"Photons\s+=\s+(\d+)", data)
        photons_per_second_match = re.search(r"([\d.]+) K photons per second", data)
        if photons_match and photons_per_second_match:
            photons = int(photons_match.group(1))
            photons_per_second = float(photons_per_second_match.group(1))
            csv_filename = self.outfile.replace('.txt', '.csv', 1)
            with open(csv_filename, "w", newline="") as f:
                writer = csv.writer(f)
                writer.writerow(["photons", "photons_per_second"])
                writer.writerow([photons, photons_per_second])
        else:
            print(f"Could not parse results in {self.outfile}")


def run_strong_scaling():
    photons_list = [521, 1024, 4096]  # in K
    threads_list = [32, 64, 128, 256, 512, 1024]
    for photons in photons_list:
        for tpb in threads_list:
            runner = TinyMcRunner(case="strong", n_runs=30, photons=photons, thr_per_block=tpb, output_dir='./results/strong_scaling')
            runner.compile()
            runner.run()
            runner.save_results()

def run_weak_scaling():
    base_photons = 512  # in K
    threads_list = [32, 64, 128, 256, 512, 1024]
    for idx, tpb in enumerate(threads_list):
        photons = base_photons * (tpb // 32)
        runner = TinyMcRunner(case="weak", n_runs=30, photons=photons, thr_per_block=tpb, output_dir='./results/weak_scaling')
        runner.compile()
        runner.run()
        runner.save_results()

if __name__ == "__main__":
    print("Running strong scaling analysis...")
    #run_strong_scaling()
    print("Running weak scaling analysis...")
    run_weak_scaling()

