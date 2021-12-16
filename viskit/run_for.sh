data_columns=$1
step_columns=$2
data_paths=$3
filename="file"
title="Title"
xlabel="xlabel"
ylabel="ylabel"

for data_paths in "path1" "path2"
do
  for filename in "file1" "file2"
  do
    python plot.py --data_columns $data_columns --step_columns $step_columns --data_paths $data_paths --filename $filename --title $title --xlabel $xlabel --ylabel $ylabel
  done
done

