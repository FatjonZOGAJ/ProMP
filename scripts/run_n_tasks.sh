#!/bin/bash
# PPO OOS
python3 run_scripts/ppo_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 40 --n_itr 500  --exp_name oos_ant_n_tasks_40_3 --eval_oos 1 --oos_high 0.75 --seed 1 # orig ppo_run_sweep
exit 0;
python3 run_scripts/ppo_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 40 --n_itr 500  --exp_name oos_ant_n_tasks_40_2 --eval_oos 1 --oos_high 0.50 --seed 1 # orig ppo_run_sweep
python3 run_scripts/ppo_run_out_of_sample.py --env AntRandGoalEnv --meta_batch_size 40 --n_itr 500  --exp_name oos_ant_n_tasks_40_1 --eval_oos 1 --oos_high 0.25 --seed 1 # orig ppo_run_sweep

exit 0;

# PPO-MAML
python3 ../run_scripts/ppo_run.py --env AntRandGoalEnv --meta_batch_size 40 --n_itr 500  --exp_name ant_n_tasks_40 # orig ppo_run_sweep
python3 ../run_scripts/ppo_run.py --env AntRandGoalEnv --meta_batch_size 10 --n_itr 2000 --exp_name ant_n_tasks_10
python3 ../run_scripts/ppo_run.py --env AntRandGoalEnv --meta_batch_size 20 --n_itr 1000 --exp_name ant_n_tasks_20
python3 ../run_scripts/ppo_run.py --env AntRandGoalEnv --meta_batch_size 80 --n_itr 250  --exp_name ant_n_tasks_80

# RL2
python3 ../run_scripts/rl2_run.py --env AntRandGoalEnv --meta_batch_size 100 --n_itr 500  --exp_name ant_n_tasks_100 # orig rl2_run_sweep
python3 ../run_scripts/rl2_run.py --env AntRandGoalEnv --meta_batch_size 20  --n_itr 2500 --exp_name ant_n_tasks_20
python3 ../run_scripts/rl2_run.py --env AntRandGoalEnv --meta_batch_size 50  --n_itr 1000 --exp_name ant_n_tasks_50
python3 ../run_scripts/rl2_run.py --env AntRandGoalEnv --meta_batch_size 200 --n_itr 250  --exp_name ant_n_tasks_200
