echo $SAVE_PATH
echo $PRETRAIN_PATH
echo $dataset
echo $lr
echo $beta
echo $ratio

deepspeed --master_addr=localhost --master_port $PORT0 --module oat.experiment.offline --gradient-checkpointing --flash-attn --rnd-seed --dap-algo DPO --pretrain SAIL-Sailor/sailor2-8B-dpo-uf-sea-v1 --apply-chat-template --ref-offload --zero-stage 3 --beta 0.1 --preference_data SAIL-Sailor/sea-uf-1122-v1model-onpolicy-score-only --max-train 5120 --prompt-max-length 1800 --generate-max-length 2048 --save-steps 100 --input-key prompt --chosen-key chosen --rejected-key rejected --train-split train --train-batch-size 128 --use-wb --wb-project sailor-oat --wb-run-name sailor2-8B-dpo-onpolicy-score-test --save_path $SAVE_PATH

deepspeed --module oat.experiment.offline --gradient-checkpointing --flash-attn --rnd-seed --dap-algo SimPO --pretrain SAIL-Sailor/sailor2-8B-dpo-uf-sea-v1 --apply-chat-template --ref-offload --zero-stage 3 --learning-rate $lr --beta $beta --gamma-beta-ratio $ratio --preference_data SAIL-Sailor/$dataset --max-train 99999 --prompt-max-length 1800 --generate-max-length 2048 --save-steps 100 --input-key prompt --chosen-key chosen --rejected-key rejected --train-split train --train-batch-size 128 --use-wb --wb-project sailor-oat --wb-run-name sailor2-8B-simpo_beta${beta}_ratio${ratio}_lr${lr}-$dataset