

# update git user
# git config user.name "user-name-here"
# git config user.email "email-here"

COMMIT_MSG=$1
if [ -z "$COMMIT_MSG" ] ; then
    echo "Invalid commit msg"
    exit 0
elif [ "$COMMIT_MSG" = "." ]; then
    echo "Invalid commit msg"
    exit 0
fi

echo "$COMMIT_MSG"
git add .
git commit -m "$COMMIT_MSG"