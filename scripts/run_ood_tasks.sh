#!/bin/bash
# OOS
# RL2
 
bsub -n 16 -R "rusage[mem=3096]" -W 24:00 -J 'oos0.25' python3 ../run_scripts/rl2_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 100 --n_itr 500 --exp_name oos_ant_n_tasks_100_1 --eval_oos 1 --oos_high 0.25 --seed 3
bsub -n 16 -R "rusage[mem=3096]" -W 24:00 -J 'oos0.50' python3 ../run_scripts/rl2_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 100 --n_itr 500 --exp_name oos_ant_n_tasks_100_2 --eval_oos 1 --oos_high 0.50 --seed 3
bsub -n 16 -R "rusage[mem=3096]" -W 24:00 -J 'oos0.75' python3 ../run_scripts/rl2_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 100 --n_itr 500 --exp_name oos_ant_n_tasks_100_3 --eval_oos 1 --oos_high 0.75 --seed 3

# PPO-MAML
bsub -n 16 -R "rusage[mem=3096]" -W 24:00 -J 'oos0.25' python3 ../run_scripts/ppo_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 40 --n_itr 500 --exp_name oos_ant_n_tasks_40_1 --eval_oos 1 --oos_high 0.25 --seed 3
bsub -n 16 -R "rusage[mem=3096]" -W 24:00 -J 'oos0.50' python3 ../run_scripts/ppo_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 40 --n_itr 500 --exp_name oos_ant_n_tasks_40_2 --eval_oos 1 --oos_high 0.50 --seed 3
bsub -n 16 -R "rusage[mem=3096]" -W 24:00 -J 'oos0.75' python3 ../run_scripts/ppo_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 40 --n_itr 500 --exp_name oos_ant_n_tasks_40_3 --eval_oos 1 --oos_high 0.75 --seed 3

