#hide any git error output
param ($newtag, $message)
 
#$env:GIT_REDIRECT_STDERR = '2>&1'
 
#getting current tag
$tagexists = (git tag)
if($tagexists -eq $null){
    $version = '0.0.0'
}
else{
    $version = (git describe --abbrev=0 --tags)
    $version = $version.Substring(1) 
}
 
#just return current version of no newtag flag
if(!$newtag){
    Write-Output "$version" | Out-String
    Exit
}
#make sure newtag flag correct
if(($newtag -ne "major") -and ($newtag -ne "minor") -and ($newtag -ne "patch")){
    Write-Host "newtag argument must be major, minor, or patch"
    Exit
}
 
#set message if not inputted
if(!$message){
    $message = "$version $newtag"
}
 
if($version -notmatch '[0-9]|[1-9][0-9].[0-9]|[1-9][0-9].[0-9]|[1-9][0-9]') {
    Write-Host "current tag is $version"
    Write-Host "tag must be formatted as v[major].[minor].[patch], where major, minor, and patch are integers"
    exit 1
}
 
$arr = $version.Split(".")
 
$major = $arr[0]
$minor = $arr[1]
$patch = $arr[2]
 
$new_major = $major -as [int]
$new_minor = $minor -as [int]
$new_patch = $patch -as [int]
 
switch($newtag) {
    "major" {
        $new_major = ($new_major + 1)
        $new_minor = 0
        $new_patch = 0
    }
    "minor" {
        $new_minor = ($new_minor + 1)
        $new_patch = 0
    }
    "patch" {
        $new_patch = ($new_patch + 1)
    }
}
 
$updated_tag = "v$new_major.$new_minor.$new_patch"
 
Write-Output "$updated_tag"
