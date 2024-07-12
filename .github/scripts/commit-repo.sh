#!/bin/bash
set -e

rsync -a --delete --exclude .git --exclude .gitignore --exclude README.md --exclude repo.json ../main/repo/ .
git config --global user.email "95863983+immortal-forest@users.noreply.github.com"
git config --global user.name "immortal-forest"
git status
if [ -n "$(git status --porcelain)" ]; then
    git add .
    git commit -m "Update extensions repo"
    git push

    # Purge cached index on jsDelivr
    curl https://purge.jsdelivr.net/gh/immortal-forest/tachi-extensions@repo/index.min.json
else
    echo "No changes to commit"
fi
