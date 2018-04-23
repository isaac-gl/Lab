#!/bin/bash
#$ -S /bin/bash
#$ -cwd

module load r/3.4.3-cairo
Rscript $*