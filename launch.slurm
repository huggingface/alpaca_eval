#!/bin/bash
#SBATCH --job-name=h4_alpaca_eval # Name of job
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --exclusive # trying to get rid of NCCL issues
#SBATCH --cpus-per-task=96 # Scale this linearly with num GPUs (i.e 1 node = 96 CPUs)
#SBATCH --mem-per-cpu=11G # Important to enable "mix" use of GPUs across cluster users
#SBATCH --gres=gpu:a100:8 # Adjust number of GPUs here
#SBATCH --output=/fsx/h4/logs/%x-%j.out # Update with output from `whoami`. Change to your personal directory if desired
#SBATCH --err=/fsx/h4/logs/%x-%j.err # Update with output from `whoami`. Change to your personal directory if desired
#SBATCH --partition=production-cluster
 
# Print shell commands and exit immediately if a command exits with a non-zero status
set -x -e

source ~/.bashrc
conda activate alpaca_eval

MODEL_CONFIG=$1
alpaca_eval evaluate_from_model $MODEL_CONFIG
