import argparse
import os
import sys

module_path = os.path.abspath(os.getcwd() + '//..')
print(module_path)
if module_path not in sys.path:
    sys.path.append(module_path)

module_path = os.path.abspath(os.getcwd())
print(module_path)
if module_path not in sys.path:
    sys.path.append(module_path)

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
    path = args.path #'../data/plots'
    os.makedirs(path, exist_ok=True)
    for x_col, y_col, label, data in zip(args.step_columns, args.data_columns,args.label_columns, exps_data):
        progress = data.progress
        print(x_col, y_col, len(data.progress))
        if args.filename == 'pearl_n_tasks_comparison.pdf':
            print('N train steps:', data.progress['Number of train steps total'][-1])
            print('N train tasks:', data.params['n_train_tasks'])
            print('N iterations :', data.params['num_iterations'])
        print('--PROGRESS_KEYS', data.progress.keys())
        print('--PARAMS', data.params)
        x = progress[x_col]
        y = progress[y_col]

        plt.plot(x, y, label=label)

    plt.xscale('log')
    # TODO: legend
    plt.legend()
    plt.ylabel(args.ylabel)
    plt.xlabel(args.xlabel)
    plt.title(args.title)
    plt.grid()
    plt.savefig(f'{path}/{args.filename}')


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--data_columns", type=str, nargs='*')
    parser.add_argument("--step_columns", type=str, nargs='*')
    parser.add_argument("--data_paths", type=str, nargs='*')
    parser.add_argument("--path", type=str, default='data\paths')
    parser.add_argument("--label_columns", type=str, nargs='*')
    parser.add_argument("--filename", type=str, default='comparison.pdf')
    parser.add_argument("--disable-variant", default=False, action='store_true')
    parser.add_argument("--title", type=str)
    parser.add_argument("--xlabel", type=str)
    parser.add_argument("--ylabel", type=str)
    args = parser.parse_args(sys.argv[1:])
    for k, v in args.__dict__.items():
        print(k, v)

    load_data()

    plot_data()
    print('Finished Plotting')
