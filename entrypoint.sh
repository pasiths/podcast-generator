#!/bin/bash

echo "===================="

git config --global user.name "${GITHUB_ACTION}
git config --global user.email "${GITHUB_EMAIL}
git config --global --add safe.directory /github/workspace

python3 /usr/local/bin/feed.py

git add -A && git commit -m "Update Feed"

git push --set-upstream origin main


echo "===================="