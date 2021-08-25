#!/bin/bash
git pull
ln -srfT ./git ~/.config/git
git config --global commit.template ~/.config/git/.gittemplates/commit
