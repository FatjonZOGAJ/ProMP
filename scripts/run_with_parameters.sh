ROOT="C:\\Users\\flori\\Documents\\Fatjon"
# TODO: still open varying meta batch-sizes, prohibiting dense sampling


# PEARL OOS
python viskit/plot.py \
--data_columns AverageReturn_all_test_tasks AverageReturn_all_test_tasks AverageReturn_all_test_tasks  AverageReturn_all_test_tasks \
--step_columns "Number of train steps total" "Number of train steps total" "Number of train steps total" "Number of train steps total" \
--data_paths $ROOT\\oyster\\output\\ant-goal\\ood1\\ $ROOT\\oyster\\output\\ant-goal\\ood2\\ $ROOT\\oyster\\output\\ant-goal\\ood3\\ $ROOT\\oyster\\output\\ant-goal\\2021_12_09_00_43_56\\ \
--filename oos_pearl_comparison.pdf \
--title "Ant-Dir Environment" \
--xlabel Steps \
--ylabel "Average Reward" \
--label_columns 90° 180° 270° 360° \

exit 0;
# RL2 OOS TODO: does not work as Eval Train column is not plotted
python viskit/plot.py \
--data_columns "Eval Step_1-AverageReturn" "Eval Step_1-AverageReturn" "Eval Step_1-AverageReturn" train-AverageReturn \
--step_columns n_timesteps n_timesteps n_timesteps n_timesteps \
--data_paths $ROOT\\ProMP\\data\\rl2\\test_oos_ant_n_tasks_100_1_37\\ $ROOT\\ProMP\\data\\rl2\\test_oos_ant_n_tasks_100_2_37\\ $ROOT\\ProMP\\data\\rl2\\test_oos_ant_n_tasks_100_3_37\\ $ROOT\\ProMP\\data\\rl2\\test_ant_n_tasks_100_594\\ \
--filename oos_rl2_comparison.pdf \
--title "Ant-Dir Environment" \
--xlabel Steps \
--ylabel "Average Reward" \
--label_columns 90° 180° 270° 360° \

exit 0;

# MAML OOS
python viskit/plot.py \
--data_columns "Eval Step_1-AverageReturn" "Eval Step_1-AverageReturn" "Eval Step_1-AverageReturn" Step_1-AverageReturn \
--step_columns n_timesteps n_timesteps n_timesteps n_timesteps \
--data_paths $ROOT\\ProMP\\data\\ppo\\test_oos_ant_n_tasks_40_1_37\\ $ROOT\\ProMP\\data\\ppo\\test_oos_ant_n_tasks_40_2_37\\ $ROOT\\ProMP\\data\\ppo\\test_oos_ant_n_tasks_40_3_37\\ $ROOT\\ProMP\\data\\ppo\\test_ant_n_tasks_40_665\\ \
--filename oos_ppo_comparison.pdf \
--title "Ant-Dir Environment" \
--xlabel Steps \
--ylabel "Average Reward" \
--label_columns 90° 180° 270° 360° \

exit 0;

# Cheetah-Dir Algorithm comparison
python viskit/plot.py \
--data_columns Step_1-AverageReturn Step_1-AverageReturn train-AverageReturn AverageReturn_all_test_tasks avgReward \
--step_columns n_timesteps n_timesteps n_timesteps "Number of train steps total" \
--data_paths $ROOT\\ProMP\\data\\ppo\\test_808\\ $ROOT\\ProMP\\data\\trpo\\test_594\\ $ROOT\\ProMP\\data\\rl2\\test_747\\ $ROOT\\oyster\\output\\cheetah-dir\\2021_11_21_23_35_15\\ \
--filename algo_comparison.pdf \
--title "Cheetah-Dir Environment" \
--xlabel Steps \
--ylabel "Average Reward" \
--label_columns PPO-MAML TRPO-MAML RL2 PEARL \
# 2 plots on fixed tasks for 2 algorithms next to each other (RL2 vs PEARL context vs gradient based)
# 2 meta batch size
# 2 out of sample

plot rl2
--data_columns train-AverageReturn train-AverageReturn train-AverageReturn train-AverageReturn --step_columns n_timesteps n_timesteps n_timesteps n_timesteps --data_paths $ROOT\ProMP\data\rl2\test_ant_n_tasks_20_541\ $ROOT\ProMP\data\rl2\test_ant_n_tasks_50_141\ $ROOT\ProMP\data\rl2\test_ant_n_tasks_100_594\ $ROOT\ProMP\data\rl2\test_ant_n_tasks_200_55\ --filename rl2_n_tasks_comparison.pdf


plot pearl
--data_columns AverageReturn_all_test_tasks AverageReturn_all_test_tasks AverageReturn_all_test_tasks AverageReturn_all_test_tasks --step_columns "Number of train steps total" "Number of train steps total" "Number of train steps total" "Number of train steps total" --data_paths $ROOT\oyster-PEARL\output\ant-goal\2021_12_09_00_43_56 $ROOT\oyster-PEARL\output\ant-goal\2021_12_09_15_20_56 $ROOT\oyster-PEARL\output\ant-goal\2021_12_09_22_19_32 $ROOT\oyster-PEARL\output\ant-goal\2021_12_11_01_36_09 --filename pearl_n_tasks_comparison.pdf

plot maml ppo
--data_columns Step_1-AverageReturn Step_1-AverageReturn Step_1-AverageReturn Step_1-AverageReturn --step_columns n_timesteps n_timesteps n_timesteps n_timesteps --data_paths $ROOT\ProMP\data\ppo\test_ant_n_tasks_10_164\ $ROOT\ProMP\data\ppo\test_ant_n_tasks_20_411\ $ROOT\ProMP\data\ppo\test_ant_n_tasks_40_665\ $ROOT\ProMP\data\ppo\test_ant_n_tasks_80_99\ --filename ppo_n_tasks_comparison.pdf


python plot.py
--data_columns
--step_columns
--data_paths
--filename
--title
--xlabel
--ylabel
