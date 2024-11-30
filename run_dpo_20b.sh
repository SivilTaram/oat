echo $SAVE_PATH
echo $PRETRAIN_PATH
echo $dataset
echo $beta

deepspeed --master_addr=localhost --master_port $PORT0 --module oat.experiment.offline --gradient-checkpointing --flash-attn --rnd-seed --dap-algo DPO --pretrain $PRETRAIN_PATH --apply-chat-template --zero-stage 3 --adam-offload --ref-offload --beta $beta --preference-data SAIL-Sailor/$dataset --max-train 99999 --prompt-max-length 2048 --generate-max-length 2048 --save-steps 100 --input-key prompt --chosen-key chosen --rejected-key rejected --train-split train --train-batch-size 128 --train-batch-size-per-device 2 --use-wb --wb-project sailor-oat --wb-run-name sailor2-20B-dpo_beta$beta-$dataset --save_path $SAVE_PATH