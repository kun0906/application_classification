#!/bin/bash
# the above line tells the shell how to execute this script
#
# job-name
#SBATCH --job-name=app_gpu_nn_pytorch
#
# need 4 nodes
##SBATCH --nodes=4 # if you write the code based on tensor, maybe you can use
##SBATCH --nodes=1
##SBATCH --cpus-per-task=8
# GPU
#SBATCH --gres=gpu:1
#
# expect the job to finish within 5 hours. If it takes longer than 5 hours, SLURM can kill it
#SBATCH --time=60:00:00
#
# expect the job to use no more than 24GB of memory
#SBATCH --mem=12GB
#
# once job ends, send me an email
#SBATCH --mail-type=END
#SBATCH --mail-user=kun.bj@icloud.com
#
# both standard output and error are directed to the same file.
#SBATCH --output=outlog_%A_%a.out
##SBATCH --error=_%A_%a.err
#SBATCH  --error=errlog_%A_%a.out
#
# first we ensure a clean running environment:
module purge
mkdir -p py3.6.3
# and load the module for the software we are using:
module load python3/intel/3.6.3
# create the virtual environment for install new libraries which do not need sudo permissions right.
virtualenv --system-site-packages py3.6.3
source py3.6.3/bin/activate
pip3 install pillow
#pip3 install scapy
pip3 install torch
pip3 install sklearn
pip3 install matplotlib

#source py3.6.3/bin/activate /home/ky13/py3.6.3
cd /scratch/ky13/Experiments/application_classification/proposed_algorithms/
### ------------------------------------------------------------------------------------------

### ------------------------------------------------------------------------------------------
#### Case5
python3 pytorch_convnet_gpu_demo.py -i '../input_data/trdata-8000B_payload.npy' -e 1000 -o '../log'
