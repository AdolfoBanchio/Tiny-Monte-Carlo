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

class TinyMcTester:
    def __init__(self, case, n):
        self.case = case
        self.makefile_rule = f"make {case}"
        self.exe = f"./{case}"
        self.runs = n

    def compile(self):
        os.system("make clean")
        os.system(self.makefile_rule)
    
    def run(self):
        with open(f"{self.case}.txt", "w") as outfile:
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
        with open(f"{self.case}.txt", "r") as f:
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
        with open(f"{self.case}.csv", "w") as f:
            f.write("photons,time,photons_per_second\n")
            for res in results:
                f.write(f"{res['photons']},{res['time']},{res['photons_per_second']}\n")


# caso 0 

tester = TinyMcTester("caso0", 10)
tester.compile()
tester.run()
tester.save_results()