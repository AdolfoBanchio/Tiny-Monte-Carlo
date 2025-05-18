import os
import matplotlib.pyplot as plt
import csv

CASE2 = "2"
CASE_PREFIXES = {"0": "512", "1": "1024", "2": "4096"}
COMPILERS = ["gcc", "icx"]

def load_files(path='./results'):
    return [file for file in os.listdir(path) if file.endswith('.csv')]

def parse_file_name(file_name):
    args = file_name.split('_')
    if len(args) < 6:
        _, case, compiler, device, photons = args
        n_threads = None
    else:
        _, case, compiler, device, photons, n_threads = args
        n_threads = n_threads.split('Th')[0]
    photons = photons.split('K')[0]
    return case, compiler, device, photons, n_threads

def initialize_structure(case, compiler, device, photons, n_threads):
    if case not in cases:
        cases[case] = {}
    if compiler not in cases[case]:
        cases[case][compiler] = {}
    if device not in cases[case][compiler]:
        cases[case][compiler][device] = {}
    if photons not in cases[case][compiler][device]:
        cases[case][compiler][device][photons] = {}

    if case == CASE2 and n_threads:
        if n_threads not in cases[case][compiler][device][photons]:
            cases[case][compiler][device][photons][n_threads] = {}

def extract_max_pps(file_path, case, compiler, device, photons, n_threads):
    with open(file_path, 'r') as f:
        reader = csv.reader(f)
        next(reader)  # Skip header
        max_pps = max(reader, key=lambda row: row[2])

        if case != CASE2:
            cases[case][compiler][device][photons] = max_pps
        else:
            cases[case][compiler][device][photons][n_threads] = max_pps

def plot_strong_scaling(devices):
    for compiler in COMPILERS:
        for device in devices:
            fig, ax = plt.subplots(figsize=(10, 4))
            thread_counts = sorted(cases[CASE2][compiler][device][CASE_PREFIXES[CASE2]].keys(), key=float)

            for size, label in CASE_PREFIXES.items():
                performance = [float(cases[CASE2][compiler][device][label][thread][2]) for thread in thread_counts]
                ax.plot(thread_counts, performance, marker='o', label=f'Size {label}K')

            ax.set_title(f'Strong Scaling Performance - Device: {device} - {compiler}')
            ax.set_ylabel('Performance [k photons/s]')
            ax.set_xticks(thread_counts)
            ax.legend(title="Problem Size")
            ax.grid(True)
            ax.set_xlabel('Number of Threads')
            plt.tight_layout()
            plt.show()

            # Save the figure
            fig.savefig(f'./graphics/strong_scaling_{device}_{compiler}_OMP.png', dpi=300)

def plot_weak_scaling(devices, output_dir='./graphics'):
    for compiler in COMPILERS:
        for device in devices:
            fig, ax = plt.subplots(figsize=(10, 4))
            sizes = sorted(cases[CASE2][compiler][device].keys(), key=float)
            print(sizes)
            threads = [list(cases[CASE2][compiler][device][size].keys())[0] for size in sizes]
            print(threads)
            performance = [float(cases[CASE2][compiler][device][size][th][2]) for size,th in zip(sizes, threads)]
            print(performance)
            ax.plot(threads, performance, marker='o')
            for i,size in enumerate(sizes):
                ax.annotate(f'{size}K', (threads[i], performance[i]), textcoords="offset points", xytext=(0,10), ha='center')

            ax.set_title(f'Weak Scaling Performance - Device: {device} - {compiler}')
            ax.set_ylabel('Performance [k photons/s]')
            #ax.set_xticks(threads)
            ax.grid(True)
            ax.set_xlabel('Number of Threads')
            plt.tight_layout()
            plt.show()

            # Save the figure
            fig.savefig(f'./graphics/weak_scaling_{device}_{compiler}_OMP.png', dpi=300)

def main():
    global cases
    cases = {}

    """ 
    For case_2 (multithreaded) two analysis are done:
    1. Strong scaling, result directory is ./results/case_2_strong_scaling
    2. Weak scaling, result directory is ./results/case_2_weak_scaling
    """
    # create strong scaling graphics
    path = './results/case_2_strong_scaling'
    os.makedirs(path, exist_ok=True)
    files = load_files(path=path)
    for file in files:
        case, compiler, device, photons, n_threads = parse_file_name(file)
        initialize_structure(case, compiler, device, photons, n_threads)
        extract_max_pps(f'{path}/{file}', case, compiler, device, photons, n_threads)
    #print(cases[CASE2]['gcc'])

    devices = sorted(cases[CASE2]['gcc'].keys())
    plot_strong_scaling(devices)

    # create weak scaling graphics
    cases = {}
    path = './results/case_2_weak_scaling'
    os.makedirs(path, exist_ok=True)
    files = load_files(path=path)
    for file in files:
        case, compiler, device, photons, n_threads = parse_file_name(file)
        initialize_structure(case, compiler, device, photons, n_threads)
        extract_max_pps(f'{path}/{file}', case, compiler, device, photons, n_threads)
    
    print(cases[CASE2]['gcc']['local-pc'].keys())
    devices = sorted(cases[CASE2]['gcc'].keys())
    plot_weak_scaling(devices, output_dir='./graphics')


if __name__ == '__main__':
    main()