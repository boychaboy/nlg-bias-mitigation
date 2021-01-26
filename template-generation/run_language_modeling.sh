MODEL_TYPE=gpt2
EPOCH=20
TRAIN_BATCH=32
VAL_BATCH=128
LR=5e-5
PATH_DIR=$(realpath .)

GPU_ID=$1
KEYWORD=$2

python -m src.run_language_modeling \
    --output_dir="models/${KEYWORD}" \
    --model_type="${MODEL_TYPE}" \
    --model_name_or_path="${MODEL_TYPE}" \
    --line_by_line \
    --overwrite_output_dir \
    --do_train \
    --train_data_file="${PATH_DIR}"/man_woman_6000_switch.txt \
    --learning_rate=$LR \
    --num_train_epochs=$EPOCH \
    --logging_steps=0 \
    --save_steps=0 \
    --gpu_id=$GPU_ID \
    --per_gpu_train_batch_size=$TRAIN_BATCH \
    --per_gpu_eval_batch_size=$VAL_BATCH

