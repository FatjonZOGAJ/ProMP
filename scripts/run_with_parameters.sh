python viskit/plot.py
--data_columns Step_1-AverageReturn Step_1-AverageReturn train-AverageReturn AverageReturn_all_test_tasks avgReward
--step_columns n_timesteps n_timesteps n_timesteps "Number of train steps total"
--data_paths /home/fatjon/Documents/Projects/ProMP/data/ppo/test_808/ /home/fatjon/Documents/Projects/ProMP/data/trpo/test_594/ /home/fatjon/Documents/Projects/ProMP/data/rl2/test_747/ /home/fatjon/Documents/Projects/oyster/output/cheetah-dir/2021_11_21_23_35_15/
--filename algo_comparison.pdf
--title "Ant-Goal Environment"
--xlabel Steps
--ylabel "Average Reward"
--label_columns PPO-MAML TRPO-MAML RL2 PEARL

exit 0;

plot rl2
--data_columns train-AverageReturn train-AverageReturn train-AverageReturn train-AverageReturn --step_columns n_timesteps n_timesteps n_timesteps n_timesteps --data_paths /home/fatjon/Documents/Projects/ProMP/data/rl2/test_ant_n_tasks_20_541/ /home/fatjon/Documents/Projects/ProMP/data/rl2/test_ant_n_tasks_50_141/ /home/fatjon/Documents/Projects/ProMP/data/rl2/test_ant_n_tasks_100_594/ /home/fatjon/Documents/Projects/ProMP/data/rl2/test_ant_n_tasks_200_55/ --filename rl2_n_tasks_comparison.pdf

plot
--data_columns "Eval Step_1-AverageReturn" "Eval Step_1-AverageReturn" "Eval Step_1-AverageReturn"
--step_columns n_timesteps n_timesteps n_timesteps n_timesteps
--data_paths /home/fatjon/Documents/Projects/ProMP/data/ppo/test_oos_ant_n_tasks_40_1_37/ /home/fatjon/Documents/Projects/ProMP/data/ppo/test_oos_ant_n_tasks_40_1_37/ /home/fatjon/Documents/Projects/ProMP/data/ppo/test_oos_ant_n_tasks_40_2_37/ /home/fatjon/Documents/Projects/ProMP/data/ppo/test_oos_ant_n_tasks_40_2_37/
--filename oos_ppo_comparison.pdf
--title "Ant-Goal Environment"
--xlabel Steps
--ylabel "Average Reward"
--label_columns PPO-MAML TRPO-MAML RL2 PEARL

plot pearl
--data_columns AverageReturn_all_test_tasks AverageReturn_all_test_tasks AverageReturn_all_test_tasks AverageReturn_all_test_tasks --step_columns "Number of train steps total" "Number of train steps total" "Number of train steps total" "Number of train steps total" --data_paths /home/fatjon/Documents/Projects/oyster-PEARL/output/ant-goal/2021_12_09_00_43_56 /home/fatjon/Documents/Projects/oyster-PEARL/output/ant-goal/2021_12_09_15_20_56 /home/fatjon/Documents/Projects/oyster-PEARL/output/ant-goal/2021_12_09_22_19_32 /home/fatjon/Documents/Projects/oyster-PEARL/output/ant-goal/2021_12_11_01_36_09 --filename pearl_n_tasks_comparison.pdf

plot maml ppo
--data_columns Step_1-AverageReturn Step_1-AverageReturn Step_1-AverageReturn Step_1-AverageReturn --step_columns n_timesteps n_timesteps n_timesteps n_timesteps --data_paths /home/fatjon/Documents/Projects/ProMP/data/ppo/test_ant_n_tasks_10_164/ /home/fatjon/Documents/Projects/ProMP/data/ppo/test_ant_n_tasks_20_411/ /home/fatjon/Documents/Projects/ProMP/data/ppo/test_ant_n_tasks_40_665/ /home/fatjon/Documents/Projects/ProMP/data/ppo/test_ant_n_tasks_80_99/ --filename ppo_n_tasks_comparison.pdf


python plot.py
--data_columns
--step_columns
--data_paths
--filename
--title
--xlabel
--ylabel
