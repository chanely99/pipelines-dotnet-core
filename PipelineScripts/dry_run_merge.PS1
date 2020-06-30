$current_branch = (git branch --show-current)
$dry_run_branch = "dry_run_$current_branch"


git branch $dry_run_branch
git checkout $dry_run_branch

git merge master