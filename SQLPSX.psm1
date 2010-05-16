
$PSXloadModules = @()
$PSXloadModules = "SQLmaint","SQLServer","Agent","Repl","SSIS","Showmbrs"
$PSXloadModules += "SQLParser","adolib" 
if ($psIse) { 
    $PSXloadModules += "SQLIse" 
}

try { 
    [System.Reflection.Assembly]::LoadWithPartialName("Oracle.DataAccess") 
    $PSXloadModules += "OracleClient"
    if ($psIse) { 
        $PSXloadModules += "OracleIse" 
    }
}
catch { Write-Host "No Oracle found" }


$PSXremoveModules = $PSXloadModules[($PSXloadModules.count)..0]

$mInfo = $MyInvocation.MyCommand.ScriptBlock.Module
$mInfo.OnRemove = {
    foreach($PSXmodule in $PSXremoveModules){
        if (gmo $PSXmodule)
        {    
          Write-Host "Removing SQLPSX Module - $PSXModule"
          Remove-Module $PSXmodule
        }
    }

    # Remomve $psScriptRoot from $env:PSModulePath
    $pathes = $env:PSModulePath -split ';' | ? { $_ -ne "$psScriptRoot\modules"}
    $env:PSModulePath = $pathes -join ';'
    #$env:PSModulePath   

    Write-Host "$($MyInvocation.MyCommand.ScriptBlock.Module.name) removed on $(Get-Date)"
}


if (($env:PSModulePath -split ';') -notcontains "$psScriptRoot\modules")
{
    $env:PSModulePath += ";" + "$psScriptRoot\modules"
}


foreach($PSXmodule in $PSXloadModules){
  Write-Host "Loading SQLPSX Module - $PSXModule"
  Import-Module $PSXmodule -global
}
Write-Host "Loading SQLPSX Modules is Done!"
