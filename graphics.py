""" 
Reads csv files from ./results and generates a plot for each case

file name: case_x_compiler_device_photons.csv
where x is the case number, 
compiler is the compiler used, 
device is the device where the test was run,
photons is the amount of photons used in the simulation


file is expected to have the following format:
photons,time,photons_per_second

Compare from each case both compilers in the same amonut of photons.
"""
import os
import csv
import matplotlib.pyplot as plt

# get all files in the results folder
files = os.listdir("./results")
files = [f for f in files if f.endswith(".csv")]

# group files by case
cases = {}
for f in files:
    case = f.split("_")[1]
    if case not in cases:
        cases[case] = []
    cases[case].append(f)

# Get average photons per second for each case and compiler

# case_0 and 32k photons

