#!/bin/bash
# --eval_oos 1 stands for evaluating on tasks that are not fixed -> see Eval step reward
#  RL2
python3 run_scripts/rl2_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 100 --n_itr 500 --exp_name fixed_ant_n_tasks_30  --fixed_tasks 1 --n_fixed_tasks 30  --seed 1 --eval_oos 1
python3 run_scripts/rl2_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 100 --n_itr 500 --exp_name fixed_ant_n_tasks_75  --fixed_tasks 1 --n_fixed_tasks 75  --seed 1 --eval_oos 1
python3 run_scripts/rl2_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 100 --n_itr 500 --exp_name fixed_ant_n_tasks_15 --fixed_tasks 1 --n_fixed_tasks 15 --seed 1 --eval_oos 1

# PPO-MAML
python3 run_scripts/ppo_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 40 --n_itr 300 --exp_name fixed_ant_n_tasks_30  --fixed_tasks 1 --n_fixed_tasks 30  --seed 1 --eval_oos 1 --num_eval_grad_steps 1
python3 run_scripts/ppo_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 40 --n_itr 300 --exp_name fixed_ant_n_tasks_75  --fixed_tasks 1 --n_fixed_tasks 75  --seed 1 --eval_oos 1 --num_eval_grad_steps 1
python3 run_scripts/ppo_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 40 --n_itr 300 --exp_name fixed_ant_n_tasks_15 --fixed_tasks 1 --n_fixed_tasks 15 --seed 1 --eval_oos 1 --num_eval_grad_steps 1
