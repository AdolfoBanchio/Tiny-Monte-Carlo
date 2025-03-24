import os
import matplotlib.pyplot as plt
import numpy as np
import csv

files = os.listdir('./results')
cases = {}

for file in files:
    if file.endswith('.csv'):
        _,case, compiler, device, photons = file.split('_')
        photons = photons.split('K')[0]
        if case not in cases:
            cases[case] = {}
        if compiler not in cases[case]:
            cases[case][compiler] = {}
        if device not in cases[case][compiler]:
            cases[case][compiler][device] = {}
        # open file and extract row of max photons per second
        with open('./results/' + file, 'r') as f:
            reader = csv.reader(f)
            next(reader)
            max_pps = max(reader, key=lambda row: row[2])
            cases[case][compiler][device][photons] = max_pps


for case in ['0', '1', '2']:
    devices = list(cases[case]['gcc'].keys())
    devices.sort()
    photons = [int(p) for p in (cases[case]['gcc'][devices[0]].keys())]
    photons.sort()
    gcc = []
    clang = []
    for device in devices:
        gcc.append([float(cases[case]['gcc'][device][str(photon)][2]) for photon in photons])
        clang.append([float(cases[case]['clang'][device][str(photon)][2]) for photon in photons])

    x = np.arange(len(photons))
    width = 0.35
    multiplier = 0


    for i, device in enumerate(devices):
        fig, ax = plt.subplots(layout='tight')
        offset = width * multiplier
        gcc_rects = ax.bar(x + offset, gcc[i], width, label='gcc')
        clang_rects = ax.bar(x + offset + width, clang[i], width, label='clang')
        ax.bar_label(gcc_rects)
        ax.bar_label(clang_rects)
        multiplier += 1

        # Add some text for labels, title and custom x-axis tick labels, etc.
        ax.set_ylabel('Velocidad [k fotones/s]')
        ax.set_xlabel('Fotones [K]')
        ax.set_title(f'Rendimiento caso 0 ({device})')
        ax.set_xticks(x + width, photons)
        ax.legend(loc='lower right', bbox_to_anchor=(1, 1))
        fig.tight_layout()
        plt.savefig(f'./graphics/case_{case}_{device}.png')
