param ($newtag)

#getting current tag
$version = (git describe --abbrev=0 --tags).Substring(1)

if(!$newtag){
    Write-Host "$version"
    Exit
}
if(($newtag -ne "major") -and ($newtag -ne "minor") -and ($newtag -ne "patch")){
    Write-Host "newtag argument must be major, minor, or patch"
    Exit
}
$message = 'message' #$env:TAGMESSAGE
$tag_update_level = $newtag#$env:TAGUPDATELEVEL



#if not specified, version is 0.0.0, message is "<version> <tag update level>"
if($version -eq $null) {
    $version = '0.0.0'
}
if($message -eq $null){
    $message = "$version $tag_update_level"
}

Write-Host "Current tag: $version"
Write-Host "tag update level: $tag_update_level"

if($version -notmatch '[0-9].[0-9].[0-9]') {
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

switch($tag_update_level) {
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

$new_tag = "v$new_major.$new_minor.$new_patch"

Write-Host "new tag: $new_tag"

git tag -a $new_tag -m $message
