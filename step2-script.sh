# RMIT University Vietnam
# Course: COSC2767 Systems Deployment and Operations
# Semester: 2023B
# Assessment: Assignment 1
# Author: Do Truong An
# ID: s3878698
# Created  date: 28/11/2023
# Last modified: 3/13/2023
# Acknowledgement:

repo_url="https://github.com/andtr-2021/COSC2767_Assignment1_BashScript_AWS_s3878698.git"
github_token="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"

# Set the GitHub token as the username for authentication
git config --global credential.helper store
echo "https://$github_token:x-oauth-basic@github.com" > ~/.git-credentials

# Perform the clone again, the token will be used for authentication
git clone "$repo_url"

# Cleanup: remove the stored credentials after the clone
rm -f ~/.git-credentials

echo "Clone completed successfully."
