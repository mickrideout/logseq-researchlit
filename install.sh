#!/bin/bash
cp post-commit .git/hooks
cp pre-commit .git/hooks
chmod a+x .git/hooks/post-commit
chmod a+x .git/hooks/pre-commit
