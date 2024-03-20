### PSReadLine ###
### PSReadLine ###
$PSReadLineOptions = @{
    HistoryNoDuplicates           = $true
    HistorySearchCursorMovesToEnd = $true
    Colors                        = @{
        Command            = '#98971a' #green
        Number             = '#d79921' #yellow
        Member             = '#458588' #blue
        Operator           = '#458588' #blue
        Type               = '#d79921' #yellow
        Variable           = '#458588' #blue
        Parameter          = '#cc241d' #red
        ContinuationPrompt = '#98971a' #green
        Default            = '#d79921' #cyan
    }
}

#Set-PSReadLineOption @PSReadLineOptions -PredictionViewStyle ListView
Set-PSReadLineOption @PSReadLineOptions

## scoop search speedup
Invoke-Expression (&sfsu hook) # need to install sfsu

## starship
$ENV:STARSHIP_CONFIG = "$HOME\.config\starship\starship.toml"
Invoke-Expression (&starship init powershell)

#  zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })


### FUNCTIONS ###

# Does the the rough equivalent of dir /s /b. For example, dirs *.png is dir /s /b *.png
function dirs {
    if ($args.Count -gt 0) {
        Get-ChildItem -Recurse -Include "$args" | Foreach-Object FullName
    }
    else {
        Get-ChildItem -Recurse | Foreach-Object FullName
    }
}

# Useful shortcuts for traversing directories
function cd... { Set-Location ..\.. }
function cd.... { Set-Location ..\..\.. }

# Compute file hashes - useful for checking successful downloads 
function md5 { Get-FileHash -Algorithm MD5 $args }
function sha1 { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }

# eza
function listlong { eza --icons -lah --color=auto --group-directories-first --hyperlink }
function list { eza --icons  --grid --color=auto --group-directories-first --hyperlink }

# edit profile with notepad
function Edit-Profile {
    if ($host.Name -match "ise") {
        $psISE.CurrentPowerShellTab.Files.Add($profile.CurrentUserAllHosts)
    }
    else {
        code $profile.CurrentUserAllHosts
    }
}

# update powershell
function Update-profile {
    pwsh.exe
}


# FZF
function fz {
    param()
    fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'
}

# cd home folder
Function CDH { Set-Location -Path ~ }


# open as admin
function Open-CurrentFolderAsAdmin {
    $currentDirectory = Get-Location
    Start-Process wt -ArgumentList "new-tab", "--startingDirectory `"$currentDirectory`"", "-p `"`"" -Verb RunAs
}

function clearH {
    ([Microsoft.PowerShell.PSConsoleReadLine]::ClearHistory())
}


### aliases ###
Set-Alias -Name np -Value C:\Windows\notepad.exe
Set-Alias -Name goh -Value CDH
Set-Alias -Name yt -Value yt-dlp
Set-Alias -Name up -Value Update-profile
Set-Alias -Name ls -Value list
Set-Alias -Name ll -Value listlong
Set-Alias admin Open-CurrentFolderAsAdmin
