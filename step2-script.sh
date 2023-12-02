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
