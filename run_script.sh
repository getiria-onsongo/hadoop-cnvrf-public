#!/bin/bash -ex

cd /mnt/cnv

START=$(date +%s)
echo "hadoop_status=running" > /home/hadoop/completed.txt

# Start hadoop job
# hadoop jar cnv.jar com.getiria_onsongo.CnvRF config_aws_16_01291_one.txt
hadoop jar cnv.jar com.getiria_onsongo.CnvRFrun config_aws_16_01291_one.txt

bucket_name=16-01291-one-1548758943-results

# Compress then move data to S3 bucket

cd /home/hadoop


tar -zcvf "${bucket_name}.tar.gz" 16_01291_one_results
aws s3 cp "${bucket_name}.tar.gz" "s3://"$bucket_name
echo "hadoop_status=completed" > /home/hadoop/completed.txt

END=$(date +%s)
DIFF=$(( $END - $START ))
DIFF_MIN=$(echo "$DIFF/60" | bc -l)

echo "Done! It took $DIFF_MIN minutes"


