#getting current tag
$version = (git describe --abbrev=0 --tags)

Write-Host "Current version: $version"

if($version -notmatch 'v[0-9].[0-9].[0-9]') {
    Write-Host "current tag is $version"
	Write-Host "tag must be formatted as v[major].[minor].[patch], where major, minor, and patch are integers"
	exit 1
}

#$input = Read-Host "What would you like to increment? (major, minor, or patch) "
$version = $version.Substring(1)
$arr = $version.Split(".")

$major = $arr[0]
$minor = $arr[1]
$patch = $arr[2]
<#
while(($input -ne "minor") -and (($input -ne "major") -and ($input -ne "patch"))){
    Write-Host "Input must be major, minor, or patch"
    $input = Read-Host "What would you like to increment? (major, minor, or patch) "
}
#>
#$message = Read-Host  "Add a message for the tag: "
$message = $env:TAGMESSAGE
$new_major = $major -as [int]
$new_minor = $minor -as [int]
$new_patch = $patch -as [int]

switch($env:TAGUPDATELEVEL) {
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


git tag -a $new_tag -m "$message"

Write-Host "new tag: $new_tag"
