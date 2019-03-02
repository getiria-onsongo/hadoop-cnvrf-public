#!/bin/bash -ex

START=$(date +%s)

# Accept ini file as a sourcable input
source config_file.txt

hadoop fs -mkdir $hdfs_dir
# Change permissions so we can move files
hadoop fs -chmod -R 777 $hdfs_dir

hadoop fs -put $local_hg19_index $hdfs_dir
hadoop fs -put picard.jar $hdfs_dir

# Change permissions so YARN can access files and folders
hadoop fs -chmod -R 777 $hdfs_dir


# Start hadoop job
hadoop jar cnv.jar com.getiria_onsongo.CnvRFrun config_file.txt

END=$(date +%s)
DIFF=$(( $END - $START ))
DIFF_MIN=$(echo "$DIFF/60" | bc -l)
echo "Done! It took $DIFF_MIN minutes"


