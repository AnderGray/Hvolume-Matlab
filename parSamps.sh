qsub -r y -j y <<EOF

#\$ -V
#\$ -q enterprise.q@iru8
#\$ -cwd
#\$ -o output.dat
#\$ -e error.dat
#\$ -N "AG1KSamples"
#\$ -pe smp 10

echo "Strating job: AnderNasa"

/apps/MATLAB/R2018b/bin/matlab -nodisplay -r TwoIncreasing

echo "Done with job: AnderModelUp"

EOF

