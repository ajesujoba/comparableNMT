#!/bin/bash

export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda/lib64
export PATH=${PATH}:/usr/local/cuda/bin
#export CUDA_VISIBLE_DEVICES=2


while read f; do
	echo $f
	outfile=~/sge/models/exp3_trans/04/eval/${f%.pt}_nt2014_fr2en_pred.txt
	python3 ~/sge/code/onmt_original/OpenNMT-py/translate.py \
		-model ~/sge/models/exp3_trans/04/model/$f \
		-src ~/sge/newstest2014/exp2b/nt.2014.bpe.fr \
		-tgt ~/sge/newstest2014/exp2b/nt.2014.bpe.en \
		-output $outfile \
		-share_vocab \
		-verbose \
		-min_length 3 \
		-batch_size 1 \
		-log_file ~/sge/models/exp3_trans/04/eval/${f%.pt}_nt2014_fr2en_eval.log
	~/sge/code/scripts/prep_eval.sh $outfile en
done < $1