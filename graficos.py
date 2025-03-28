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
    devices = list(cases[case]['gcc-14'].keys())
    devices.sort()
    photons = [int(p) for p in (cases[case]['gcc-14'][devices[0]].keys())]
    photons.sort()
    gcc = []
    clang = []
    icx = []
    for device in devices:
        gcc.append([float(cases[case]['gcc-14'][device][str(photon)][2]) for photon in photons])
        clang.append([float(cases[case]['clang-19'][device][str(photon)][2]) for photon in photons])
        icx.append([float(cases[case]['icx'][device][str(photon)][2]) for photon in photons])

    x = np.arange(len(photons))
    width = 0.3  # the width of the bars
    group_spacing = 0.5  # spacing between groups of bars

    for i, device in enumerate(devices):
        fig, ax = plt.subplots(figsize=(10, 6))
        offset = i * (3 * width + group_spacing)  # Offset for each device group
        gcc_rects = ax.bar(x + offset, gcc[i], width, label='gcc-14')
        clang_rects = ax.bar(x + offset + width, clang[i], width, label='clang-19')
        icx_rects = ax.bar(x + offset + 2 * width, icx[i], width, label='icx')

        ax.bar_label(gcc_rects)
        ax.bar_label(clang_rects)
        ax.bar_label(icx_rects)

        # Add some text for labels, title and custom x-axis tick labels, etc.
        ax.set_ylabel('Velocidad [k fotones/s]')
        ax.set_xlabel('Fotones [K]')
        ax.set_title(f'Rendimiento caso {case} ({device})')
        ax.set_xticks(x + offset + width)
        ax.set_xticklabels(photons)
        ax.legend(loc='lower right', bbox_to_anchor=(1, 1))
        fig.tight_layout()
        plt.savefig(f'./graphics/case_{case}_{device}.png')
