#!/bin/bash
# FIXED 50, 100, 500, 1000
# PPO-MAML
# --eval_oos 1 stands for evaluating on tasks that are not fixed -> See Eval step reward
python3 run_scripts/ppo_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 40 --n_itr 300 --exp_name fixed_ant_n_tasks_50   --fixed_tasks 1 --n_fixed_tasks 50   --seed 1 --eval_oos 1 --num_eval_grad_steps 1
python3 run_scripts/ppo_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 40 --n_itr 300 --exp_name fixed_ant_n_tasks_100  --fixed_tasks 1 --n_fixed_tasks 100  --seed 1 --eval_oos 1 --num_eval_grad_steps 1
python3 run_scripts/ppo_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 40 --n_itr 300 --exp_name fixed_ant_n_tasks_500  --fixed_tasks 1 --n_fixed_tasks 500  --seed 1 --eval_oos 1 --num_eval_grad_steps 1
python3 run_scripts/ppo_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 40 --n_itr 300 --exp_name fixed_ant_n_tasks_1000 --fixed_tasks 1 --n_fixed_tasks 1000 --seed 1 --eval_oos 1 --num_eval_grad_steps 1

# TODO: RL2