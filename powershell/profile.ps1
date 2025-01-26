Set-Alias -Name l -Value Get-ChildItemPretty

function Get-ChildItemPretty {
    param (
        [Parameter(Mandatory=$false, Position=0)]
        [string]$Path=$PWD
    )
    eza -la --icons $Path
    
}
