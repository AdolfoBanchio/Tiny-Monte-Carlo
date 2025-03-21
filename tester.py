""" 
Modulo de testeo para los diferentes casos de uso.

El objeto toma como parametro el nombre del caso a testear.
Tendra 3 metodos:
    - compilar
    - ejecutar y guardar salida
    - generar grafico de salida
"""
import os
import matplotlib.pyplot as plt
import re
import subprocess

class TinyMcRuner:
    def __init__(self, case, n, compiler="gcc"):
        self.case = case
        self.exe = f"./{case}"
        self.runs = n
        self.compiler = compiler
        self.makefile_rule = f"make CC={compiler} {case}"
        self.outfile = f"./results/{case}_{compiler}.txt"
    def compile(self):
        os.system("make clean")
        os.system(self.makefile_rule)
    
    def run(self):
        with open(self.outfile, "w") as outfile:
            # Run command and capture stderr (perf stat output)
            process = subprocess.run(
                ["sudo", "perf", "stat", "-r", str(self.runs), self.exe],
                stdout=outfile, stderr=subprocess.PIPE, text=True
            )
        print(process.stderr)

    def save_results(self):
        """  
        el archivo de salida tendra el siguiente formato repetido n veces:

        # Tiny Monte Carlo by Scott Prahl (http://omlc.ogi.edu)
        # 1 W Point Source Heating in Infinite Isotropic Scattering Medium
        # CPU version, adapted for PEAGPGPU by Gustavo Castellano and Nicolas Wolovick
        # Scattering =   20.000/cm
        # Absorption =    2.000/cm
        # Photons    =    32768
        #
        # 0.076823 seconds
        # 426.540226 K photons per second
        # Radius	Heat
        # [microns]	[W/cm^3]	Error
        # extra	     0.00000
        
        Extraer los datos:
            - cantidad de fotones simulados
            - tiempo de ejecucion
            - cantidad de fotones por segundo
        """
        with open(self.outfile, "r") as f:
                    data = f.read()

        # separar los datos con la linea "# extra"
        runs = re.split(r"(# extra\s+[\d.e+-]+)", data)

        results = []
        for i in range(0, len(runs)-1, 2):
            
            # extraer cantidad de photones
            photons = int(re.search(r"Photons\s+=\s+(\d+)", runs[i]).group(1))

            # extraer tiempo de ejecucion
            time = float(re.search(r"(\d+\.\d+) seconds", runs[i]).group(1))

            # extraer cantidad de fotones por segundo
            photons_per_second = float(re.search(r"(\d+\.\d+) K photons per second", runs[i]).group(1))

            res = {
                "photons": photons,
                "time": time,
                "photons_per_second": photons_per_second
            }
            results.append(res)
        # crear csv
        with open(f"./results/{self.case}_{self.compiler}.csv", "w") as f:
            f.write("photons,time,photons_per_second\n")
            for res in results:
                f.write(f"{res['photons']},{res['time']},{res['photons_per_second']}\n")


# caso 0 

for i in range(0,3):
    for c in ["gcc", "clang"]:
        case = f"case_{i}"
        runner = TinyMcRuner(case, 10, compiler=c)
        runner.compile()
        runner.run()
        runner.save_results()

        # TODO: generar grafico
        data = []
        with open(f"./results/{case}_{c}.csv", "r") as f:
            for line in f:
                if "photons" in line:
                    continue
                data.append(list(map(float, line.split(","))))

        data = list(zip(*data))
        plt.plot(data[0], data[2], label=case)