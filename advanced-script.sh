
# this script will be run on the learner lab terminal
aws ec2 create-key-pair --key-name a1 --query 'KeyMaterial' --output text > a1.pem
# edit the permissions for the file owner to read and write (6), and denies all permissions for other users (0).
# make it more secure
chmod 600 MyKeyPair.pem
# create a security group
command_output=$(aws ec2 create-security-group --group-name a1_server100 --description "My security group" --vpc-id vpc-0c0d6536daf9aaeb3)

# Extracting GroupId from the command output using jq (assuming the output is in JSON format)
group_id=$(echo $command_output | jq -r '.GroupId')

# Print or use the GroupId as needed
echo "GroupId: $group_id"
# check out the security-groups
aws ec2 describe-security-groups --group-ids $group_id
# modify the security group rules
# port 22 used for ssh
aws ec2 authorize-security-group-ingress \
    --group-id $group_id \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0
# port 8080 used by Tomcat server
aws ec2 authorize-security-group-ingress \
    --group-id $group_id \
    --protocol tcp \
    --port 8080 \
    --cidr 0.0.0.0/0

aws ec2 run-instances --image-id ami-0fa1ca9559f1892ec --count 1 --instance-type t2.micro --key-name MyKeyPair --security-group-ids $group_id --subnet-id subnet-05379441ae6f20873