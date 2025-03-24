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
import csv
import platform 

class TinyMcRuner:
    def __init__(self, case, n, compiler="gcc", photons=32):
        self.case = case
        self.exe = f"./{case}"
        self.runs = n
        self.compiler = compiler
        self.outfile = f"./results/{case}_{compiler}_{photons}k.txt"
        self.photons = photons

    def compile(self):
        subprocess.run(["make", "clean"], check=True)
        subprocess.run(["make", f"CC={self.compiler}", self.case, f"PHOTONS={self.photons*1024}"], check=True)
    
    def run(self):
        with open(self.outfile, "w") as outfile:
            try:
                process = subprocess.run(
                    ["perf", "stat", "-r", str(self.runs), self.exe],
                    stdout=outfile, stderr=subprocess.PIPE, text=True, check=True
                )
                print(process.stderr)
            except subprocess.CalledProcessError as e:
                print(f"Error executing perf: {e}")

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

        # extraer nombre del dispositivo donde se ejecuto
        device = platform.node()
        with open(f"./results/{self.case}_{self.compiler}_{device}_{self.photons}K.csv", "w", newline="") as f:
            writer = csv.DictWriter(f, fieldnames=["photons", "time", "photons_per_second"])
            writer.writeheader()
            writer.writerows(results)


# caso 0 

for i in range(0,3):
    for c in ["gcc-14", "clang-19", "icx"]:
        for f in [32, 128, 512]:
            case = f"case_{i}"
            runner = TinyMcRuner(case, 30, compiler=c, photons=f)
            runner.compile()
            runner.run()
            runner.save_results()

            # TODO: generar grafico
            data = []
            device = platform.node()
            with open(f"./results/{case}_{c}_{device}_{f}K.csv", "r") as f:
                for line in f:
                    if "photons" in line:
                        continue
                    data.append(list(map(float, line.split(","))))

            data = list(zip(*data))
            plt.plot(data[0], data[2], label=case)
