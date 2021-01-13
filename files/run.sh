#!/bin/bash
#PBS -N _GPOOL
#PBS -q long
#PBS -l nodes=1:ppn=20
#PBS -l walltime=720:00:00

[ -e ~/.bashrc ] && source ~/.bashrc
[ "$PBS_O_WORKDIR" ] && cd $PBS_O_WORKDIR


[ -e /home/scicons/profiles/profile.g09 ] && source /home/scicons/profiles/profile.g09




export GAUSS_SCRDIR=`mktemp -d`

env > ENV
for i in $(ls *.gjf *.com); do
    log=${i%.*}.log
    chk=${i%.*}.chk
    [ -e $log ] && [ "$i" -ot "$log" ] && continue
    touch $i
    g09 $i && formchk $chk
done
