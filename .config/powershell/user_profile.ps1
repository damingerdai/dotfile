Import-Module posh-git
Import-Module oh-my-posh
# Set-PoshPrompt -Theme Paradox
Set-PoshPrompt -Theme default
oh-my-posh prompt init pwsh --config '~\.config\powershell\default.omp.json' | Invoke-Expression

Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'