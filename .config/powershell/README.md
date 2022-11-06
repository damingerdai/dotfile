# oh my posh

```posh
winget install JanDeDobbeleer.OhMyPosh -s winget
```

```posh
notepad $PROFILE


Import-Module posh-git
Import-Module oh-my-posh
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
Set-PoshPrompt -Theme default
oh-my-posh prompt init pwsh --config '~\.config\powershell\default.omp.json' | Invoke-Expression
```


# refernce

1. [Windows Terminal美化（oh-my-posh3）](https://zhuanlan.zhihu.com/p/354603010)