import os
import matplotlib.pyplot as plt
import numpy as np
import csv

CASE0= "0"
CASE1= "1"
CASE2= "2"

TAM0 = "512"
TAM1 = "1024"
TAM2 = "4096"

files = os.listdir('./results')
cases = {}

def main(): 
    #Structure data 
    for file in files:
        if file.endswith('.csv'):
            args  = file.split('_') 
            if (len(args)<6): 
                _,case, compiler, device, photons = args
            else:
                _,case, compiler, device, photons,n_threads = args  
                n_threads= n_threads.split('Th')[0]
            photons = photons.split('K')[0]
            if case not in cases:
                cases[case] = {}
            if compiler not in cases[case]:
                cases[case][compiler] = {}
            if device not in cases[case][compiler]:
                cases[case][compiler][device] = {}
            if photons not in  cases[case][compiler][device]: 
                cases[case][compiler][device][photons] = {}
            if case == CASE2 and n_threads not in cases[case][compiler][device][photons]: 
                cases[case][compiler][device][photons][n_threads] = {}
            
            # open file and extract row of max photons per second
            with open('./results/' + file, 'r') as f:
                reader = csv.reader(f)
                next(reader)
                max_pps = max(reader, key=lambda row: row[2])
                if (case != CASE2): 
                    cases[case][compiler][device][photons] = max_pps
                else: 
                    cases[case][compiler][device][photons][n_threads] = max_pps
    # #Plots
    # for case in ['0', '1']:
    #     devices = list(cases[case]['gcc-14'].keys())
    #     devices.sort()
    #     photons = [int(p) for p in (cases[case]['gcc-14'][devices[0]].keys())]
    #     photons.sort()
    #     gcc = []
    #     clang = []
    #     icx = []
    #     for device in devices:
    #         gcc.append([float(cases[case]['gcc-14'][device][str(photon)][2]) for photon in photons])
    #         clang.append([float(cases[case]['clang-19'][device][str(photon)][2]) for photon in photons])
    #         icx.append([float(cases[case]['icx'][device][str(photon)][2]) for photon in photons])

    #     x = np.arange(len(photons))
    #     width = 0.3  # the width of the bars
    #     group_spacing = 0.5  # spacing between groups of bars

    #     for i, device in enumerate(devices):
    #         fig, ax = plt.subplots(figsize=(10, 6))
    #         offset = i * (3 * width + group_spacing)  # Offset for each device group
    #         gcc_rects = ax.bar(x + offset, gcc[i], width, label='gcc-14')
    #         clang_rects = ax.bar(x + offset + width, clang[i], width, label='clang-19')
    #         icx_rects = ax.bar(x + offset + 2 * width, icx[i], width, label='icx')

    #         ax.bar_label(gcc_rects)
    #         ax.bar_label(clang_rects)
    #         ax.bar_label(icx_rects)

    #         # Add some text for labels, title and custom x-axis tick labels, etc.
    #         ax.set_ylabel('Velocidad [k fotones/s]')
    #         ax.set_xlabel('Fotones [K]')
    #         ax.set_title(f'Rendimiento caso {case} ({device})')
    #         ax.set_xticks(x + offset + width)
    #         ax.set_xticklabels(photons)
    #         ax.legend(loc='lower right', bbox_to_anchor=(1, 1))
    #         fig.tight_layout()
    #         plt.savefig(f'./graphics/case_{case}_{device}.png')

    #Case 2 - Plot weak scaling 
    devices = list(cases[case]['gcc'].keys())
    devices.sort()
    # Crear subplots: uno por device (en una sola columna)
    fig, axes = plt.subplots(len(devices), 1, figsize=(10, 4 * len(devices)), sharex=True)

    # Si solo hay un dispositivo, axes no es una lista: lo forzamos a ser iterable
    if len(devices) == 1:
        axes = [axes]

    for i, d in enumerate(devices):
        ax = axes[i]

        # Extraer los hilos (x)
        raw_threads = list(cases[case]['gcc'][d][photons].keys())
        x = sorted(raw_threads, key=lambda h: float(h))  # Ordenar por valor numérico
        print(x)

        # Extraer el performance para cada tamaño y cantidad de hilos
        y_tam0 = []
        y_tam1 = []
        y_tam2 = []

        for t in x:  
            y_tam0.append(cases['2']['gcc'][d][TAM0][t][2])
            y_tam1.append(cases['2']['gcc'][d][TAM1][t][2])       
            y_tam2.append(cases['2']['gcc'][d][TAM2][t][2])
            

        #x.plot(x, y, marker='o') 
        ax.plot(x,y_tam0) 
        ax.plot(x,y_tam1)
        ax.plot(x,y_tam2)
        ax.set_title(f'Device: {d}')
        ax.set_ylabel('Performance')
        ax.grid(True)
        ax.set_xticks(x)  # Solo los hilos disponibles

    axes[-1].set_xlabel('# hilos')  # solo el último subplot tiene xlabel

    plt.tight_layout()
    plt.show()


main()