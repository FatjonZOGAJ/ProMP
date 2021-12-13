Setup repository
git clone https://github.com/FatjonZOGAJ/ProMP.git
cd ProMP/
git fetch
git checkout full_code

Setup environment
```
conda create -n ProMP python=3.6
source activate ProMP

pip3 install --upgrade pip

# install MPI
#wget https://github.com/mpi4py/mpi4py/releases/download/3.1.3/mpi4py-3.1.3.tar.gz
#tar -zxf mpi4py-3.1.3.tar.gz
#cd mpi4py-3.1.3
#python3 -m pip install -e .

conda install mpi4py

pip install -r requirements.txt
```

Install Mujoco
```
mkdir ../.mujoco
wget https://www.roboti.us/download/mjpro131_linux.zip
unzip mjpro131_linux.zip -d ../.mujoco

wget https://mujoco.org/download/mujoco210-linux-x86_64.tar.gz
tar -xzvf mujoco210-linux-x86_64.tar.gz 
mv mujoco210 ../.mujoco/mujoco210

wget https://www.roboti.us/file/mjkey.txt ../.mujoco/mjkey.txt

export MUJOCO_PY_MJPRO_PATH=/cluster/home/fzogaj/.mujoco/mjpro131
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/cluster/home/fzogaj/.mujoco/mujoco210/bin

```
 
Manually install Mesa if 'mujoco py install error - fatal error: GL/osmesa.h: No such file or directory'
```
# https://github.com/openai/mujoco-py/issues/96#issuecomment-601887590  
# https://github.com/openai/mujoco-py/issues/96#issuecomment-346685411
mkdir rpm
cd rpm
for url in http://mirror.centos.org/centos/7/os/x86_64/Packages/mesa-libOSMesa-18.3.4-10.el7.x86_64.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/mesa-libOSMesa-devel-18.3.4-10.el7.x86_64.rpm; do
    curl $url | rpm2cpio | cpio -id
done

export PATH="$PATH:$HOME/rpm/usr/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/rpm/usr/lib:$HOME/rpm/usr/lib64"
export LDFLAGS="-L$HOME/rpm/usr/lib -L$HOME/rpm/usr/lib64"                                                                                                 
export CPATH="$CPATH:$HOME/rpm/usr/include"

conda install -c conda-forge patchelf 
```

Turn off warning
```
sed -i '/logger.warn("gym.spaces.Box autodetected dtype as %s. Please provide explicit dtype." % dtype)/c\#logger.warn("gym.spaces.Box autodetected dtype as %s. Please provide explicit dtype." % dtype)' /cluster/home/fzogaj/miniconda3/envs/ProMP/lib/python3.6/site-packages/gym/spaces/box.py
```