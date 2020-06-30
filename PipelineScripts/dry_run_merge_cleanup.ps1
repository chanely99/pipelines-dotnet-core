$dry_run_branch = (git branch --show-current)
$original_branch = ($dry_run_branch -split 'dry_run_')[1]

git checkout $original_branch
git branch -D $dry_run_branch

