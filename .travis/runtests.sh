#!/bin/bash
set -e

# Get version of Python in current docker container
PY_VER=`python -c \
        "from sys import version_info as ver; \
        print('py%s%s' % (ver.major, ver.minor))"`

# Name of generated data of code coverage
COVERAGE_FILE=".coverage.$PY_VER"
# Name of branch where the generated data of code coverage to be pushed
GIT_BRANCH="cov-$PY_VER"

# Module name for test (for "run_tests_with_coverage")
MODULE_NAME="mymodule"

# Import defined functions from another script
THIS_DIR=`dirname $0`
source "$THIS_DIR"/utils.sh


# ----- Processes for running tests -----
# Config name and email of Git user
setup_git_for_travis
# Config url of upstream with authenticated token. Otherwise, we cannot
# push files back to our repository
setup_git_upstream

# Check whether the branch for storing coverage data does exist. If not,
# create that branch
exist=`check_branch_exists`
if [ $exist -eq 0 ]; then
    create_branch_for_coverage "$GIT_BRANCH"
fi

run_tests_with_coverage

# Commit and push coverage data to that branch. (note that we should pull
# that branch first)
pull_branch_for_coverage "$GIT_BRANCH"
commit_artifacts "$GIT_BRANCH" "$COVERAGE_FILE"
push_artifacts "$GIT_BRANCH"
