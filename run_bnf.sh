echo $SAVE_PATH
echo $PRETRAIN_PATH
echo $dataset
echo $bnf_lr

deepspeed --master_addr=localhost --master_port $PORT0 --module oat.experiment.offline --gradient-checkpointing --flash-attn --rnd-seed --dap-algo BNF --pretrain $PRETRAIN_PATH --apply-chat-template --ref-offload --zero-stage 3 --learning-rate $bnf_lr --preference_data SAIL-Sailor/$dataset --max-train 99999 --prompt-max-length 1800 --generate-max-length 2048 --save-steps 100 --input-key prompt --chosen-key chosen --rejected-key rejected --train-split train --train-batch-size 128 --use-wb --wb-project sailor-oat --wb-run-name sailor2-8B-bnf_lr${bnf_lr}-$dataset --save_path $SAVE_PATH