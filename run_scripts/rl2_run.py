import argparse
import sys
import os
import sys
module_path = os.path.abspath(os.getcwd() + '//..')
print(module_path)
if module_path not in sys.path:
    sys.path.append(module_path)

from maml_zoo.baselines.linear_baseline import LinearFeatureBaseline
from maml_zoo.envs.mujoco_envs.half_cheetah_rand_direc import HalfCheetahRandDirecEnv
from maml_zoo.envs.mujoco_envs.ant_rand_goal import AntRandGoalEnv
from maml_zoo.envs.rl2_env import rl2env
from maml_zoo.algos.vpg import VPG
from maml_zoo.algos.ppo import PPO
from maml_zoo.trainer import Trainer
from maml_zoo.utils.utils import set_seed
from maml_zoo.samplers.maml_sampler import MAMLSampler
from maml_zoo.samplers.rl2_sample_processor import RL2SampleProcessor
from maml_zoo.policies.meta_gaussian_mlp_policy import MetaGaussianMLPPolicy
from maml_zoo.policies.gaussian_rnn_policy import GaussianRNNPolicy
import os
from maml_zoo.logger import logger
import json
import numpy as np

maml_zoo_path = '/'.join(os.path.realpath(os.path.dirname(__file__)).split('/')[:-1])

from tensorflow.python.util import deprecation
deprecation._PRINT_DEPRECATION_WARNINGS = False

def main(config):
    baseline = LinearFeatureBaseline()
    env = rl2env(eval(config['env'])())
    obs_dim = np.prod(env.observation_space.shape) + np.prod(env.action_space.shape) + 1 + 1
    policy = GaussianRNNPolicy(
            name="meta-policy",
            obs_dim=obs_dim,
            action_dim=np.prod(env.action_space.shape),
            meta_batch_size=config['meta_batch_size'],
            hidden_sizes=config['hidden_sizes'],
            cell_type=config['cell_type']
        )

    sampler = MAMLSampler(
        env=env,
        policy=policy,
        rollouts_per_meta_task=config['rollouts_per_meta_task'],  # This batch_size is confusing
        meta_batch_size=config['meta_batch_size'],
        max_path_length=config['max_path_length'],
        parallel=config['parallel'],
        envs_per_task=1,
    )

    sample_processor = RL2SampleProcessor(
        baseline=baseline,
        discount=config['discount'],
        gae_lambda=config['gae_lambda'],
        normalize_adv=config['normalize_adv'],
        positive_adv=config['positive_adv'],
    )

    algo = PPO(
        policy=policy,
        learning_rate=config['learning_rate'],
        max_epochs=config['max_epochs']
    )

    trainer = Trainer(
        algo=algo,
        policy=policy,
        env=env,
        sampler=sampler,
        sample_processor=sample_processor,
        n_itr=config['n_itr'],
    )
    trainer.train()


if __name__=="__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--meta_batch_size", type=int)
    parser.add_argument("--n_itr", type=int)
    parser.add_argument("--exp_name", type=str)
    parser.add_argument("--env", type=str)
    parser.add_argument("--seed", type=int, default=1)
    args = parser.parse_args(sys.argv[1:])

    set_seed(args.seed)
    idx = np.random.randint(0, 1000)
    data_path = maml_zoo_path + f'/data/rl2/test_{args.exp_name}_{idx}'
    logger.configure(dir=data_path, format_strs=['stdout', 'log', 'csv'],
                     snapshot_mode='last_gap')
    config = json.load(open(maml_zoo_path + "/configs/rl2_config.json", 'r'))
    for k, v in args._get_kwargs():
        config[k] = v
        print(k, v)
    json.dump(config, open(data_path + '/params.json', 'w'))
    main(config)
