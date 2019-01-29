#!/bin/bash

aws emr create-cluster --auto-scaling-role EMR_AutoScaling_DefaultRole --applications Name=Hadoop \
--ebs-root-volume-size 10 \
--ec2-attributes '{"KeyName":"reviewer-one","InstanceProfile":"EMR_EC2_DefaultRole","SubnetId":"subnet-45f11721","EmrManagedSlaveSecurityGroup":"sg-958817ef","EmrManagedMasterSecurityGroup":"sg-3b8a1541"}' \
--service-role EMR_DefaultRole \
--release-label emr-5.13.0 \
--repo-upgrade-on-boot SECURITY \
--name '16_01291_one' \
--instance-groups '[{"InstanceCount":4,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":200,"VolumeType":"gp2"},"VolumesPerInstance":1}]},"InstanceGroupType":"CORE","InstanceType":"m5.xlarge","Name":"Core"},{"InstanceCount":1,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":200,"VolumeType":"gp2"},"VolumesPerInstance":1}]},"InstanceGroupType":"MASTER","InstanceType":"m5.xlarge","Name":"Master"}]' \
--configurations file://configurations.json \
--scale-down-behavior TERMINATE_AT_TASK_COMPLETION \
--custom-ami-id ami-8f057cf7 \
--enable-debugging --log-uri s3://gonsongo-emr-logs \
--region us-west-2
