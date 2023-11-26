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
# turn on tomcat
tomcatup
# back to root
cd ~
# generate maven web template. create anProfile
mvn archetype:generate -DgroupId=vn.edu.rmit -DartifactId=anProfile -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
# move to anProfile folder
cd anProfile/
# move to webapp folder
cd src/main/webapp/

# edit the file index.jsp
html_file="index.jsp"  # Set the file name
# Define the new line to add
new_line='<h1>Do Truong An</h1>'
# Define a pattern to search for in the HTML file
pattern='<body>'
# Check if the pattern exists in the HTML file
if grep -qF "$pattern" "$html_file"; then
    # Insert the new line below the pattern
    sed -i "/$pattern/ a $new_line" "$html_file"
    echo "Changes made to $html_file"
else
    echo "Pattern not found in $html_file: $pattern. Changes not applied."
fi

# go back to root
cd ~
# move to webapp folder
cd anProfile/
# compile and build the web
mvn package
# Deploy the WAR artifacts on Tomcat serve
cp /root/anProfile/target/anProfile.war /opt/tomcat/webapps/

