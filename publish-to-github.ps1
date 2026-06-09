param(
  [string]$RepoFullName
)

if (-not $RepoFullName) {
  $RepoFullName = Read-Host "GitHub repo, for example username/niuyou-exam"
}

if (-not ($RepoFullName -match "^[^/]+/[^/]+$")) {
  Write-Error "RepoFullName must look like username/repo"
  exit 1
}

$remote = "https://github.com/$RepoFullName.git"

git remote remove origin 2>$null
git remote add origin $remote
git push -u origin main

$parts = $RepoFullName.Split("/")
$owner = $parts[0]
$repo = $parts[1]

Write-Host ""
Write-Host "Pushed to $remote"
if ($repo -eq "$owner.github.io") {
  Write-Host "Site URL should be: https://$repo/"
} else {
  Write-Host "Open Pages settings and choose Deploy from branch: main / root"
  Write-Host "Settings: https://github.com/$RepoFullName/settings/pages"
  Write-Host "Site URL should be: https://$owner.github.io/$repo/"
}
