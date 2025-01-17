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

from maml_zoo.utils import set_seed
from maml_zoo.baselines.linear_baseline import LinearFeatureBaseline
from maml_zoo.envs.point_envs.point_env_2d import MetaPointEnv
from maml_zoo.envs.mujoco_envs.half_cheetah_rand_direc import HalfCheetahRandDirecEnv
from rand_param_envs.hopper_rand_params import HopperRandParamsEnv
from maml_zoo.envs.mujoco_envs.ant_rand_goal import AntRandGoalEnv
from maml_zoo.envs.normalized_env import normalize
from maml_zoo.meta_algos.ppo_maml import PPOMAML
from maml_zoo.meta_trainer_out_of_sample import Trainer
from maml_zoo.samplers.maml_sampler import MAMLSampler
from maml_zoo.samplers.maml_sample_processor import MAMLSampleProcessor
from maml_zoo.policies.meta_gaussian_mlp_policy import MetaGaussianMLPPolicy
import os
from maml_zoo.logger import logger
import json
import numpy as np

maml_zoo_path = '/'.join(os.path.realpath(os.path.dirname(__file__)).split('/')[:-1])


def main(config):
    baseline = LinearFeatureBaseline()
    env = normalize(eval(config['env'])(evaluate_out_of_sample_low=config['oos_low'],
                                        evaluate_out_of_sample_high=config['oos_high'],
                                        fixed_tasks=config['fixed_tasks'],
                                        n_fixed_tasks=config['n_fixed_tasks']))
    # env = HopperRandParamsEnv(3.5)
    policy = MetaGaussianMLPPolicy(
        name="meta-policy",
        obs_dim=np.prod(env.observation_space.shape),
        action_dim=np.prod(env.action_space.shape),
        meta_batch_size=config['meta_batch_size'],
        hidden_sizes=config['hidden_sizes'],
    )

    sampler = MAMLSampler(
        env=env,
        policy=policy,
        rollouts_per_meta_task=config['rollouts_per_meta_task'],  # This batch_size is confusing
        meta_batch_size=config['meta_batch_size'],
        max_path_length=config['max_path_length'],
        parallel=config['parallel'],
    )

    sample_processor = MAMLSampleProcessor(
        baseline=baseline,
        discount=config['discount'],
        gae_lambda=config['gae_lambda'],
        normalize_adv=config['normalize_adv'],
        positive_adv=config['positive_adv'],
    )

    algo = PPOMAML(
        policy=policy,
        inner_lr=config['inner_lr'],
        meta_batch_size=config['meta_batch_size'],
        num_inner_grad_steps=config['num_inner_grad_steps'],
        learning_rate=config['learning_rate'],
        num_ppo_steps=config['num_ppo_steps'],
        num_minibatches=config['num_minibatches'],
        clip_eps=config['clip_eps'],
        clip_outer=config['clip_outer'],
        target_outer_step=config['target_outer_step'],
        target_inner_step=config['target_inner_step'],
        init_outer_kl_penalty=config['init_outer_kl_penalty'],
        init_inner_kl_penalty=config['init_inner_kl_penalty'],
        adaptive_outer_kl_penalty=config['adaptive_outer_kl_penalty'],
        adaptive_inner_kl_penalty=config['adaptive_inner_kl_penalty'],
        anneal_factor=config['anneal_factor'],
    )

    # Out of Sample Trainer
    trainer = Trainer(
        algo=algo,
        policy=policy,
        env=env,
        sampler=sampler,
        sample_processor=sample_processor,
        n_itr=config['n_itr'],
        num_inner_grad_steps=config['num_inner_grad_steps'],  # This is repeated in MAMLPPO, it's confusing
        num_eval_grad_steps=config['num_eval_grad_steps'],
        evaluate_out_of_sample=config['eval_oos']
    )
    trainer.train()


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--meta_batch_size", type=int)
    parser.add_argument("--n_itr", type=int)
    parser.add_argument("--rollouts_per_meta_task", type=int, default=20)
    parser.add_argument("--exp_name", type=str)
    parser.add_argument("--env", type=str)
    parser.add_argument("--seed", type=int, default=1)

    # Out of sample parameters
    parser.add_argument("--eval_oos", type=bool, default=True)
    parser.add_argument("--num_eval_grad_steps", type=int, default=2)
    parser.add_argument("--oos_low", type=int, default=0)
    parser.add_argument("--oos_high", type=float, default=1)  # percentage, 1 = 2 * PI

    # Fixed Tasks parameters
    parser.add_argument("--fixed_tasks", type=bool, default=False)
    parser.add_argument("--n_fixed_tasks", type=int, default=0)

    args = parser.parse_args(sys.argv[1:])
    args.oos_high = 2 * np.pi * args.oos_high

    set_seed(args.seed)

    idx = np.random.randint(0, 1000)
    data_path = maml_zoo_path + f'/data/ppo/test_{args.exp_name}_{idx}'
    logger.configure(dir=data_path, format_strs=['stdout', 'log', 'csv'],
                     snapshot_mode='last_gap')
    config = json.load(open(maml_zoo_path + "/configs/ppo_maml_config.json", 'r'))
    for k, v in args._get_kwargs():
        config[k] = v
        print(k, v)
    json.dump(config, open(data_path + '/params.json', 'w'))
    main(config)
