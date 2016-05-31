#!/bin/bash

# generate gnuplot plot script for showing the datafiles
# the datafiles is generated by file2sliceD

if [ $# -lt 1 ]
then
	cat << EOF
Usage: $0 num1 num2 num3 filehead
	num1: the min of file order
	num2: the max of file order
	num3: the number step
	filehead: filename is filehead + num

EOF

	exit 1
fi


begin=$1
end=$2
step=$3
filehead=$4

pltfile="./pltslices.plt"

echo "set terminal wxt enhanced"   > ${pltfile}
echo "set xlabel \"{/Symbol q}\"" >> ${pltfile}
echo "set ylabel \"{/symbol g}\"" >> ${pltfile}
echo "unset key" >> ${pltfile}
for (( i=${begin}; i<=${end}; i=$((i+step)) ))
do
#    ./readpa.m slice${i}.dpa par${i}
    echo "${filehead}${i} u 2:1 w p pt 7 ps 0.1,\\" 
done | sed -e "s/\([^ ]*\)/'\1'/;\$s/..$//;1s/^/plot /" >> ${pltfile}