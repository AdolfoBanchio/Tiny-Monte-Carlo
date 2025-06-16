import os
import matplotlib.pyplot as plt
import csv
import platform

def get_best_result_from_csv(csv_path):
    """Return the best (max) photons_per_second from a CSV file."""
    best = None
    with open(csv_path, newline='') as f:
        reader = csv.DictReader(f)
        for row in reader:
            try:
                pps = float(row['photons_per_second'])
                if best is None or pps > best:
                    best = pps
            except Exception:
                continue
    return best

def get_threads_from_filename(filename):
    # Assumes ..._<N>Th.csv or ..._TPB<N>.csv
    import re
    m = re.search(r'_(\d+)Tpb', filename)
    if m:
        return int(m.group(1))
    return None

def get_photons_from_filename(filename):
    import re
    m = re.search(r'_(\d+)K', filename)
    if m:
        return int(m.group(1))
    m = re.search(r'PHOTONS(\d+)_', filename)
    if m:
        return int(m.group(1))
    return None

def get_device_from_filename(filename):
    import re
    m = re.search(r'_(\w+)_', filename)
    if m:
        return m.group(1)
    return None
    
def plot_strong_scaling(results_dir, output_path):
    """
    Plot strong scaling: for each problem size (photons), plot best photons_per_second vs threads_per_block.
    """
    # Find all csvs in results_dir
    files = [f for f in os.listdir(results_dir) if f.endswith('.csv')]
    # Group by photons
    data = {}
    for f in files:
        photons = get_photons_from_filename(f)
        threads = get_threads_from_filename(f)
        if photons is None or threads is None:
            continue
        best_pps = get_best_result_from_csv(os.path.join(results_dir, f))
        if photons not in data:
            data[photons] = []
        data[photons].append((threads, best_pps))
    # Plot
    fig, ax = plt.subplots(figsize=(10, 4))
    for photons, vals in sorted(data.items()):
        vals = sorted(vals)
        threads, pps = zip(*vals)
        ax.plot(threads, pps, marker='o', label=f'{photons}K photons')
    thread_counts = sorted(set(t for t, _ in vals))
    ax.set_title(f'Strong Scaling Performance')
    ax.set_ylabel('Performance [k photons/s]')
    ax.set_xticks(thread_counts)
    ax.legend(title="Problem Size")
    ax.grid(True)
    ax.set_xlabel('Number of Threads')
    plt.tight_layout()

    fig.savefig(output_path)

def plot_weak_scaling(results_dir, output_path):
    """
    Plot weak scaling: plot best photons_per_second vs threads_per_block (photons scales with threads).
    """
    files = [f for f in os.listdir(results_dir) if f.endswith('.csv')]
    vals = []
    sizes = []
    for f in files:
        threads = get_threads_from_filename(f)
        sizes.append(get_photons_from_filename(f))
        best_pps = get_best_result_from_csv(os.path.join(results_dir, f))
        if threads is not None and best_pps is not None:
            vals.append((threads, best_pps))
    vals = sorted(vals)
    sizes = sorted(set(sizes))
    if vals:
        threads, pps = zip(*vals)
        fig, ax = plt.subplots(figsize=(10, 4))
        ax.plot(threads, pps, marker='o')
        for i, size in enumerate(sizes):
            ax.annotate(f'{size}K', (threads[i], pps[i]), textcoords="offset points", xytext=(0,10), ha='center')            
        ax.set_title(f'Weak Scaling Performance')
        ax.set_ylabel('Performance [k photons/s]')
        ax.set_xticks(threads)
        ax.grid(True)
        ax.set_xlabel('Number of Threads')
        plt.tight_layout()
        plt.savefig(output_path)
        plt.close()

if __name__ == "__main__":
    # Adjust these paths as needed
    strong_dir = './results/strong_scaling'
    weak_dir = './results/weak_scaling'
    plot_strong_scaling(strong_dir, 'strong_scaling.png')
    plot_weak_scaling(weak_dir, 'weak_scaling.png')
    print('Plots saved as strong_scaling.png and weak_scaling.png')

