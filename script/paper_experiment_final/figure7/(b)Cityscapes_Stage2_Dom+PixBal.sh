round=3
checkpoint_path=checkpoint/deepstem50_do_ppredclsbal_coff6_my_bvsb_predclsbal_pwr_banignore_sp2048_nlbl100.0k_iter80.0k_method-active_predignore-_coeff1.0_ignFalse_lr4e-05_

# python eval_AL.py -p "$checkpoint_path" \
# --stage2 \
# --datalist_path "$checkpoint_path"/datalist_0"$round".pkl \
# --init_checkpoint "$checkpoint_path"/checkpoint0"$round".tar \
# --resume_checkpoint "$checkpoint_path"/checkpoint0"$round".tar \
# --method eval_save_cosplbl_prop_onehotignore \
# --dominant_labeling \
# --train_transform eval_dom_gt_spx \
# --loader region_cityscapes_dom_w_gt \
# --ce_temp 0.1 \
# --nseg 2048 \
# --model deeplabv3pluswn_resnet50deepstem \
# --separable_conv \
# --val_batch_size 1 \
# --wandb_tags eval \
# --num_workers 8 \
# --dontlog

python train_stage2_AL.py -p "$checkpoint_path" \
--stage2 \
--init_iteration "$round" \
--datalist_path "$checkpoint_path"/datalist_0"$round".pkl \
--resume_checkpoint "$checkpoint_path"/checkpoint0"$round".pkl \
--init_checkpoint checkpoint/city_res50deepstem_imagenet_pretrained.tar \
--finetune_itrs 80000 \
--val_period 5000 \
--val_start 0 \
--active_selection_size 50000 \
--train_transform rescale_769_nospx \
--model deeplabv3pluswn_resnet50deepstem \
--separable_conv \
--optimizer adamw \
--train_lr 0.00004 \
--ce_temp 0.1 \
--cls_lr_scale 10.0 \
--scheduler poly \
--train_batch_size 4 \
--num_workers 10 \
--val_batch_size 4 \
--nseg 2048 \
--dominant_labeling \
--method active_predignore \
--loader region_cityscapes_plbl \
--wandb_tags 50k plbl cos