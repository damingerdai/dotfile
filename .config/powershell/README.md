# oh my posh

```posh
winget install JanDeDobbeleer.OhMyPosh -s winget
```

```posh
notepad $PROFILE


Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme default
oh-my-posh prompt init pwsh --config '~\.config\powershell\default.omp.json' | Invoke-Expression
```