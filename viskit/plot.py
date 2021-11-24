import argparse
import os
import sys

from viskit import core
from viskit.core import flatten
from viskit.frontend import reload_data

import matplotlib.pyplot as plt

def load_data():
    global exps_data
    global plottable_keys
    global distinct_params
    exps_data = core.load_exps_data(args.data_paths, args.disable_variant)
    plottable_keys = sorted(list(
        set(flatten(list(exp.progress.keys()) for exp in exps_data)) - {None}))
    distinct_params = sorted(core.extract_distinct_params(exps_data))


def plot_data():
    path = '../data/plots'
    os.makedirs(path, exist_ok=True)
    for x_col, y_col, data in zip(args.step_columns, args.data_columns, exps_data):
        progress = data.progress
        print(x_col, y_col, len(data.progress))
        x = progress[x_col]
        y = progress[y_col]

        plt.plot(x, y, label = data['params']['algo'] if 'algo' in data['params'] else 'PEARL')

    plt.xscale('log')
    plt.legend()
    plt.ylabel('Average Reward')
    plt.xlabel('Steps')
    plt.title('Cheetah-Direction Environment')
    plt.savefig(f'{path}/comparison.pdf')




if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--data_columns", type=str, nargs='*')
    parser.add_argument("--step_columns", type=str, nargs='*')
    parser.add_argument("--data_paths", type=str, nargs='*')
    parser.add_argument("--disable-variant", default=False, action='store_true')
    args = parser.parse_args(sys.argv[1:])

    load_data()

    plot_data()
    print(5)