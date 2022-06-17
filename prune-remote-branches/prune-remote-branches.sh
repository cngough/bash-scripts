// get list with -d to do a dry run
// check yes/no input
// if yes, perform same with -D

git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D

// also:
// git branch -r --merged | egrep -v "(^\*|master|dev)" | sed 's/origin\///' | xargs -n 1 git push origin --delete
