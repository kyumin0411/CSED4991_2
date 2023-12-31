python train_AL.py -p checkpoint/woproto_deepstem50_ppredclsbal_pwr_bdrytrim5x5 \
--model deeplabv3pluswn_resnet50deepstem \
--init_checkpoint checkpoint/city_res50deepstem_imagenet_pretrained.tar \
--method active_joint_multi_predignore_lossdecomp \
--active_method my_bvsb_predclsbal_pwr_banignore \
--cls_weight_coeff 6.0 \
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
--wandb_tags 50k base cos ablation \
--multi_ce_temp 0.1 \
--group_ce_temp 0.1 \
--ce_temp 0.1 \
--coeff 16.0 \
--coeff_mc 8.0 \
--coeff_gm 0.0 \
--init_iteration 1 \
--trim_kernel_size 5 \
--trim_multihot_boundary