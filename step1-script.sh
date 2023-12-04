# RMIT University Vietnam
# Course: COSC2767 Systems Deployment and Operations
# Semester: 2023B
# Assessment: Assignment 1
# Author: Do Truong An
# ID: s3878698
# Created  date: 28/11/2023
# Last modified: 3/13/2023
# Acknowledgement: 

# Set variables
KEY_NAME="MyKeyPair149"
SECURITY_GROUP_NAME="MyServer149"
VPC_ID="vpc-0c0d6536daf9aaeb3"
IMAGE_ID="ami-0fa1ca9559f1892ec"
SUBNET_ID="subnet-05379441ae6f20873"
PORT_SSH=22
PORT_TOMCAT=8080

# Create key pair
aws ec2 create-key-pair --key-name $KEY_NAME --query 'KeyMaterial' --output text > "$KEY_NAME.pem"
# Edit permissions for the file owner
chmod 600 "$KEY_NAME.pem"
# Create a security group
command_output=$(aws ec2 create-security-group --group-name $SECURITY_GROUP_NAME --description "My security group" --vpc-id $VPC_ID)
# Extract GroupId from the command output using jq (assuming JSON format)
group_id=$(echo "$command_output" | jq -r '.GroupId')
# Print or use the GroupId as needed
echo "GroupId: $group_id"

# Authorize security group rules
authorize_security_group() {
    aws ec2 authorize-security-group-ingress \
        --group-id $group_id \
        --protocol tcp \
        --port $1 \
        --cidr 0.0.0.0/0
}
# Authorize SSH port
authorize_security_group $PORT_SSH
# Authorize Tomcat port
authorize_security_group $PORT_TOMCAT
# Launch the instance
aws ec2 run-instances --image-id $IMAGE_ID --count 1 --instance-type t2.micro --key-name $KEY_NAME --security-group-ids $group_id --subnet-id $SUBNET_ID

sleep 30
# Wait for the instance to be running
instance_id=$(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].InstanceId" --output text)
while [ -z "$instance_id" ]; do
    echo "Waiting for the instance to be running..."
    sleep 45
    instance_id=$(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].InstanceId" --output text)
done

echo "Instance is running with ID: $instance_id"

# SSH into the instance
ssh_command="ssh -i $KEY_NAME.pem ec2-user@$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)"
echo "Running SSH command: $ssh_command"
$ssh_command
