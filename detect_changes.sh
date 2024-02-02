#!/bin/bash

# Define the base branch or reference point, if needed
# BASE_BRANCH="main"

# Fetch the latest state of the base branch and ensure all branches are up to date
# git fetch origin $BASE_BRANCH:$BASE_BRANCH

# Define the sub-projects in the monorepo
declare -a PROJECTS=("simple-express-server" "simple-react-app" "simple-shared-data")

# Directory where the projects are located, if nested within a subdirectory like 'packages'
PROJECT_DIR="packages"

# Initialize an empty array for changed projects
CHANGED_PROJECTS=()

# Get a list of changed files in the last commit
CHANGED_FILES=$(git diff --name-only HEAD~1..HEAD)

# Loop through each project and check if any file has changed in it
for PROJECT in "${PROJECTS[@]}"; do
    for FILE in $CHANGED_FILES; do
        if [[ $FILE == $PROJECT_DIR/$PROJECT/* ]]; then
            CHANGED_PROJECTS+=("$PROJECT")
            # Break after the first match to avoid duplicate entries
            break
        fi
    done
done

# Output the changed projects, space-separated
echo ${CHANGED_PROJECTS[@]}
