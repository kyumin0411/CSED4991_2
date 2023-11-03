#!/bin/sh
## JOB 이름
#SBATCH -J deepstem50 # Job name

## LOG 적을 위치
#SBATCH -o sbatch_log/pytorch-1gpu.%j.out # Name of stdout output file (%j expands to %jobId)

## GPU 종류
#SBATCH -p 3090 # queue name or partiton name titanxp/titanrtx/2080ti/3090

## 최대 사용 시간
#SBATCH -t 3-00:00:00 # Run time (hh:mm:ss) - 1.5 hours

## 노드 지정하지않기
# #SBATCH --nodes=1
## 제외할 node (사용할거면 # 한 개만)
# #SBATCH --exclude=n28

## 사용할 node (사용할거면 # 한 개만)
# #SBTACH --nodelist=n29

#### Select GPU
## gpu 개수
#SBATCH --gres=gpu:1 # number of gpus you want to use
#SBTACH --ntasks=1
##SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=10

cd $SLURM_SUBMIT_DIR
echo "SLURM_SUBMIT_DIR=$SLURM_SUBMIT_DIR"
echo "CUDA_HOME=$CUDA_HOME"
echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
echo "CUDA_VERSION=$CUDA_VERSION"

srun -l /bin/hostname
srun -l /bin/pwd
srun -l /bin/date

## path Erase because of the crash
#module load postech

echo "Start"
export WANDB_SPAWN_METHOD=fork

date
nvidia-smi
python train_AL.py -p checkpoint/deepstem50_bvsb_bdrytrim5x5 \
--model deeplabv3pluswn_resnet50deepstem \
--init_checkpoint checkpoint/city_res50deepstem_imagenet_pretrained.tar \
--method active_joint_multi_predignore_lossdecomp \
--active_method my_bvsb_banignore \
--or_labeling \
--fair_counting \
--loss_type joint_multi_loss \
--nseg 2048 \
--scheduler poly \
--train_lr 0.00002 \
--start_over \
--num_workers 12 \
--finetune_itrs 80000 \
--val_period 5000 \
--val_start 0 \
--separable_conv \
--max_iterations 5 \
--train_transform rescale_769_multi_notrg \
--loader region_cityscapes_or_tensor \
--active_selection_size 100000 \
--wandb_tags 50k base cos \
--init_iteration 1 \
--multi_ce_temp 0.1 \
--group_ce_temp 0.1 \
--ce_temp 0.1 \
--coeff 16.0 \
--coeff_mc 8.0 \
--coeff_gm 1.0 \
--init_iteration 1 \
--trim_kernel_size 5 \
--trim_multihot_boundary