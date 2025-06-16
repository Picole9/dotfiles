Set-Alias -Name l -Value Get-ChildItemPretty
Set-Alias -Name touch -Value New-File
Set-Alias -Name vi -Value Open-Nvim
Set-Alias -Name which -Value Where-File

function Get-ChildItemPretty {
    <#
    .SYNOPSIS
        list files
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false, Position=0)]
        [string]$Path=$PWD
    )
    eza -la --icons $Path
    
}

function Open-Nvim {
    <#
    .SYNOPSIS
        open with nvim from wsl
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false, Position=0)]
        [string]$Path=$PWD
    )
    wsl -e nvim (($Path -replace "\\","/") -replace ":","").ToLower().Trim("/")
}

function New-File {
    <#
    .SYNOPSIS
        creates new file
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Name
    )
    Write-Verbose "Creating new file '$Name'"
    New-Item -ItemType File -Name $Name -Path $PWD | Out-Null
}

function Where-File {
    <#
    .SYNOPSIS
        show definition of program
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Name
    )
    Get-Command $Name | Select-Object -ExpandProperty Definition
}
