# SCManagerBackdoor
SCManagerBackdoor Script as described in An ACE in the Hole talk Derbycon7

# Install
Set-ExecutionPolicy Bypass
Import-Module Set-SCManagerBackdoor

# Usage
Set-SCManagerBackdoor -RemoteComputer "IP\remotecomp.domain.com" -Username "domain\myusername"

# ToDo
MayBe Add functionality add service as well with Delete privileges
https://msdn.microsoft.com/en-us/library/windows/desktop/ms685981(v=vs.85).aspx#access_rights_for_the_service_control_manager

# Credits
@harmj0y
@wald0
@vysec
