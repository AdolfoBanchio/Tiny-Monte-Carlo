""" 
Modulo de testeo para los diferentes casos de uso.

El objeto toma como parametro el nombre del caso a testear.
Tendra 3 metodos:
    - compilar
    - ejecutar y guardar salida
    - generar grafico de salida
"""
import os

import re
import subprocess
import csv
import platform 
import numpy as np

CASE0= f"case_{0}"
CASE1= f"case_{1}"
CASE2= f"case_{2}"
class TinyMcRuner:
    def __init__(self, case, n, compiler="gcc", photons=32, n_threads=8):
        self.case = case
        self.exe = f"./{case}"
        self.runs = n
        self.compiler = compiler
        self.outfile = f"./results/{case}_{compiler}_{photons}k_{n_threads}.txt"
        self.photons = photons
        self.n_threads= n_threads
        if "adolfo" in platform.node():
            self.device = "local-pc"
        else:
            self.device = platform.node()

    def compile(self):
        subprocess.run(["make", "clean"], check=True)
        subprocess.run(["make", f"CC={self.compiler}", self.case, f"PHOTONS={self.photons*1024}", f"N_THREADS={self.n_threads}"], check=True)
    
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
        if self.case == CASE2: 
            with open(f"./results/{self.case}_{self.compiler}_{self.device}_{self.photons}K_{self.n_threads}Th.csv", "w", newline="") as f:
                writer = csv.DictWriter(f, fieldnames=["photons", "time", "photons_per_second"])
                writer.writeheader()
                writer.writerows(results)
        else: 
            with open(f"./results/{self.case}_{self.compiler}_{self.device}_{self.photons}K.csv", "w", newline="") as f:
                writer = csv.DictWriter(f, fieldnames=["photons", "time", "photons_per_second"])
                writer.writeheader()
                writer.writerows(results)

cores = os.cpu_count()
for i in range(2,3):
    for c in ["gcc"]:
        for f in [512,1024,4096]:
            case = f"case_{i}"
            if case != CASE2:
                runner = TinyMcRuner(case, 50, compiler=c, photons=f)
                runner.compile()
                runner.run()
                runner.save_results()

            else: 
                # generate an array of 8 equidistant numbers between 1 and cores
                # for each number, run the test with that number of threads 
                n_threads_list = np.linspace(1, cores, 8, dtype=int)
                n_threads_list = np.unique(n_threads_list)
                for n_threads in n_threads_list:
                    runner = TinyMcRuner(case, 50, compiler=c, photons=f,n_threads=n_threads)
                    runner.compile()
                    runner.run()
                    runner.save_results()

