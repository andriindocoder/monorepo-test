#!/bin/bash

# Base branch to compare (e.g., master)
BASE_BRANCH="dev"

# # Get a list of changed files compared to the BASE_BRANCH
CHANGED_FILES="$(git diff --name-only HEAD $(git merge-base HEAD $BASE_BRANCH))"
# CHANGED_FILES="$(git diff --name-only)"
# CHANGED_FILES="$(git diff --name-only origin/main...HEAD)"
# CHANGED_FILES=$(git diff --name-only "origin/$BASE_BRANCH"...HEAD)
# CHANGED_FILES=$(git diff --name-only HEAD~1..HEAD)
# Define the sub-projects in the monorepo
# echo "$CHANGED_FILES"
declare -a PROJECTS=("packages/simple-express-server" "packages/simple-react-app" "packages/simple-shared-data")

# Initialize an empty array for changed projects
CHANGED_PROJECTS=()

# Loop through each project and check if any file has changed in it
for PROJECT in "${PROJECTS[@]}"; do
    for FILE in $CHANGED_FILES; do
        if [[ $FILE == $PROJECT/* ]]; then
            # Extract only the project folder name without the 'packages/' prefix
            PROJECT_NAME=$(basename $PROJECT)
            CHANGED_PROJECTS+=("$PROJECT_NAME")
            break
        fi
    done
done

# Output the changed projects, space-separated
echo ${CHANGED_PROJECTS[@]}
