data_columns=$1
step_columns=$2
data_paths=$3
filename=$4
title=$5
xlabel=$6
ylabel=$7

python plot.py --data_columns $data_columns --step_columns $step_columns --data_paths $data_paths --filename $filename --title $title --xlabel $xlabel --ylabel $ylabel
