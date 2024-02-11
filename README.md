# Automate Web Deployment with Maven, Tomcat & AWS EC2

### Objectives

The main objective of this project is to automate the process of building and deploying a personal website on AWS EC2 instance with bash script. This project requires three steps. The first step is to set up an AWS EC2 instance. The second is bash script writing. The bash script file has to be able to automate the processes including installing Java, install and set up Maven to Path and install Tomcat. The final step is to execute and test the bash script.

### Technologies Used

To implement this project, software and tools including Git, BashScript, Java, Maven, Tomcat and AWS will be used

- Git is a famous open source version control system and is used for tracking the code changes.
- Bash Scripting is a file containing a list of Shell commands that will be executed sequentially.
- Java is a multi-platforms and object-oriented programming language that is a popular choice between the developer for creating web and mobile applications.
- Apache Maven is a powerful management tool that can be used to build and manage any Java-based application, especially web application.
- Apache Tomcat is a web server and servlet container that is used to deploy and host web applications.
- Amazon Web Services is a cloud computing platform that offers countless services including storage, database, management tools, etc. Organisations can use these services to quickly update their products, making them more competitive.

### Aumate EC2 Instance Creation using AWS CloudShell 

- To automate EC2 instance creation and launch using a Bash script on AWS CloudShell, gather essential metadata from your AWS Learner Lab account, including VPC Id, Subnet Id, and AMI Id. Obtain the VPC Id and Subnet Id by navigating through the AWS Management Console and extracting the relevant information from the VPC and Subnets sections. For the AMI Id, locate and select the desired Amazon Machine Image (AMI) in the EC2 Dashboard.
- Once all metadata is collected, access the AWS Management Console Dashboard via CloudShell, and proceed to create a key pair using the 'aws ec2 create-key-pair' command. Subsequently, create a security group with 'aws ec2 create-security-group' and modify its rules using 'aws ec2 authorize-security-group-ingress' to allow access on necessary ports. Finally, launch the EC2 instance with 'aws ec2 run-instances,' ensuring to customize variables like image-id, instance-type, key-name, security-group-ids, and subnet-id. After the instance is up, SSH into it using 'ssh -i <file_name>.pem ec2-user@<public_ip>.'
- Executing the Bash script generates the GroupId, confirms security group rule modifications, and successfully brings up the instance. Note that setting the instance name through Bash is not supported via aws cli, but you can manually add the name under the Name column in the AWS Management Console after the instance creation.

