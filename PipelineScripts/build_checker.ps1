$build_failed = $false

if($build_failed) {
    "Build failed, aborting merge"
    exit 1
}else{
    Write-Host "Build succeeded, merging changes"
}


