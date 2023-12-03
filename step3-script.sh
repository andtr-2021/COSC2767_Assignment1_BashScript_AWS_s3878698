# RMIT University Vietnam
# Course: COSC2767 Systems Deployment and Operations
# Semester: 2023B
# Assessment: Assignment 1
# Author: Do Truong An
# ID: s3878698
# Created  date: 28/11/2023
# Last modified: 3/13/2023
# Acknowledgement:

# setup openjdk
sudo amazon-linux-extras install -y java-openjdk11
# move to opt dir
cd /opt
# install maven
wget https://dlcdn.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.tar.gz
# unzip maven
tar -xvzf apache-maven-3.9.5-bin.tar.gz
# rename maven
mv apache-maven-3.9.5 maven
# find jvm folder
find / -name jvm
# back to root
cd ~

# SETUP enviroments variables for maven
new_lines='
# User specific environment and startup programs
M2_HOME=/opt/maven
M2=/opt/maven/bin
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.20.0.8-1.amzn2.0.1.x86_64

PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2

export PATH
'

# Define a pattern to search for in the bash_profile
pattern='# User specific environment and startup programs'

# Check if the pattern exists in bash_profile
if grep -qF "$pattern" ~/.bash_profile; then
    # Replace lines after the pattern with the new_lines
    sed -i "/$pattern/,$ d" ~/.bash_profile
    echo "$new_lines" >> ~/.bash_profile
    echo "Changes made to ~/.bash_profile"
else
    echo "Pattern not found in ~/.bash_profile: $pattern. Changes not applied."
fi

echo $PATH

source .bash_profile

echo $PATH
# DONE SETUP for enviroment variables

# back to opt dir
cd /opt
# install tomcat
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.83/bin/apache-tomcat-9.0.83.tar.gz
# unzip tomcat
tar -xvzf apache-tomcat-9.0.83.tar.gz
# change name tomcat
mv apache-tomcat-9.0.83 tomcat
# setup hybolic links to startup and shutdown tomcat
ln -s /opt/tomcat/bin/startup.sh /usr/local/bin/tomcatup
ln -s /opt/tomcat/bin/shutdown.sh /usr/local/bin/tomcatdown
# turn on tomcat to test
tomcatup
# turn off tomcat to test
tomcatdown

# then turn on for the webapp
tomcatup
# back to root
cd ~

# generate maven web template. create anProfile project
mvn archetype:generate -DgroupId=vn.edu.rmit -DartifactId=anProfile -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false

# move to webapp folder
cd anProfile/src/main/webapp/

# add the profile website to the index.jsp file
echo '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Do Truong An</title>
    <style>
        body {
            font-family: monospace;
            font-size: 16px;
            margin-left: 200px;
            margin-top: 30px;
            padding: 20px;
        }

        h1 {
            color: #333;
        }

        h1:hover, a:hover {
            color: red; /* Change text color */
        }

        p {
            color: #666;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        li {
            margin-bottom: 5px;
            color: #666;
        }

        footer {
            margin-top: 20px;
            color: #888;
        }
    </style>
</head>
<body>
    <h1><a href="https://github.com/andtr-2021">Do Truong An</a></h1>
    <h3>Information:</h3>
    <p><strong>sID:</strong> s3878698</p>
    <p><strong>Major:</strong> Software Engineering</p>

    <h3>Programming Skills:</h3>
    <ul>
        <li><strong>Languages:</strong> Python, Java, C++, SQL, HTML/CSS/JavaScript.</li>
        <li><strong>Frameworks:</strong> Keras, TensorFlow, Spring.</li>
    </ul>

    <footer>
        <p>Contact me at: <a href="mailto:s3878698@rmit.edu.vn">s3878698@rmit.edu.vn</a></p>
    </footer>
</body>
</html>' > index.jsp


# go back to root
cd ~
# move to webapp folder
cd anProfile/
# compile and build the web
mvn package
# Deploy the WAR artifacts on Tomcat serve
cp /root/anProfile/target/anProfile.war /opt/tomcat/webapps/

