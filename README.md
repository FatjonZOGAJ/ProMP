# On the Robustness of Context- and Gradient-based Meta-Reinforcement Learning Algorithms

For installing MuJoCo refer [here](https://github.com/openai/mujoco-py).


## Setting the environment

```bash
virtualenv venv --python=python3.7
source venv/bin/activate
pip install -r requirements.txt
```


## Reproduce results

Run meta-training with online evaluations with any of the scripts in `scripts/`. e.g.
       
```
#PPO-MAML
bsub -n 16 -R "rusage[mem=3096]" -W 24:00 -J 'meta_bach_size40seed3' python3 ../run_scripts/ppo_run.py --env AntRandGoalEnv --meta_batch_size 40 --n_itr 500  --exp_name meta_batch_size_40 --seed 3 # orig ppo_run_sweep
bsub -n 16 -R "rusage[mem=3096]" -W 24:00 -J 'meta_bach_size10seed3' python3 ../run_scripts/ppo_run.py --env AntRandGoalEnv --meta_batch_size 10 --n_itr 2000 --exp_name meta_batch_size_10 --seed 3
bsub -n 16 -R "rusage[mem=3096]" -W 24:00 -J 'meta_bach_size20seed3' python3 ../run_scripts/ppo_run.py --env AntRandGoalEnv --meta_batch_size 20 --n_itr 1000 --exp_name meta_batch_size_20 --seed 3
bsub -n 16 -R "rusage[mem=3096]" -W 24:00 -J 'meta_bach_size80seed3' python3 ../run_scripts/ppo_run.py --env AntRandGoalEnv --meta_batch_size 80 --n_itr 250  --exp_name meta_batch_size_80 --seed 3

#RL2
bsub -n 16 -R "rusage[mem=3096]" -W 24:00 -J 'meta_bach_size100seed3' python3 ../run_scripts/rl2_run.py --env AntRandGoalEnv --meta_batch_size 100 --n_itr 500  --exp_name meta_batch_size_100  --seed 3 # orig rl2_run_sweep
bsub -n 16 -R "rusage[mem=3096]" -W 24:00 -J 'meta_bach_size25seed3' python3 ../run_scripts/rl2_run.py --env AntRandGoalEnv --meta_batch_size 25  --n_itr 2000 --exp_name meta_batch_size_25 --seed 3
bsub -n 16 -R "rusage[mem=3096]" -W 24:00 -J 'meta_bach_size50seed3' python3 ../run_scripts/rl2_run.py --env AntRandGoalEnv --meta_batch_size 50  --n_itr 1000 --exp_name meta_batch_size_50 --seed 3
bsub -n 16 -R "rusage[mem=3096]" -W 24:00 -J 'meta_bach_size200seed3' python3 ../run_scripts/rl2_run.py --env AntRandGoalEnv --meta_batch_size 200 --n_itr 250  --exp_name meta_batch_size_200 --seed 3
```

