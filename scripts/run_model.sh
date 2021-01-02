#!/usr/bin/env bash

echo "Model type: ${1}"
echo "No ext sample name: ${2}"

# Modify params.
export DATA_DIR=$(dirname ${2})
export TEST_BASE=$(basename ${2})

# Fixed params.
export MAX_LENGTH=128
export REGARD3_OUTPUT_DIR=models/bert_regard_v3
export SENTIMENT2_OUTPUT_DIR=models/bert_sentiment_v2
export TEST_FILE=${TEST_BASE}.tsv.XYZ

if [[ ${1} == "regard3" ]]
then
    export OUTPUT_DIR=${REGARD3_OUTPUT_DIR}
    export BERT_MODEL=${OUTPUT_DIR}/checkpoint-300
    export MODEL_VERSION=3
elif [[ ${1} == "sentiment2" ]]
then
    export OUTPUT_DIR=${SENTIMENT2_OUTPUT_DIR}
    export BERT_MODEL=${OUTPUT_DIR}/checkpoint-60
    export MODEL_VERSION=2

fi
export OUTPUT_PREFIX=${DATA_DIR}/${1}_${TEST_BASE}.tsv

echo "Labeling with classifier..."
python3 scripts/run_classifier.py --data_dir ${DATA_DIR} \
--model_type bert \
--model_name_or_path ${BERT_MODEL} \
--output_dir ${OUTPUT_DIR} \
--max_seq_length  ${MAX_LENGTH} \
--do_predict \
--test_file ${TEST_FILE} \
--do_lower_case \
--overwrite_cache \
--per_gpu_eval_batch_size 32 \
--model_version ${MODEL_VERSION}

echo "Done!"
