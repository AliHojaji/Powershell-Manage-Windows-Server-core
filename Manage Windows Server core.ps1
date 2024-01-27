#--- Author : Ali Hojaji ---#

#--*------------------------------*--#
#---> Manage Windows Server Core <---#
#--*------------------------------*--#

#--> enter a powershell session on a remote machine
Enter-PSSession -ComputerName Core-Test

#--> view all available features
Get-windowsFeature

#--> install web server (iis) role and management service
Install-WindowsFeature -Name web-server, web-Mgmt-Service

#--> view installed features
Get-WindowsFeature | Where-Object Installed -EQ True

#--> configure remote management for IIs
Set-Itemproperty -Path "HKLM:\software\Microsoft\WebManagment\Server" -Name "EnableRemoteManagement" -Value 1

#--> configure remote managent service to start automatically
Set-Service WMSVC -StartupType Automatic

#--> rename a computer
Rename-Computer -NewName WEB-NUG -DomainCredential "nuggetlab\administrator" -Force -Restart

#--> exit remote powershell session
Exit-PSSession

#--> send a command over to a remote machine (powershell remoting - http)
Invoke-Command -ComputerName WEB-Test -ScriptBlock { Get-Service W35VC,WMSVC }

#--> use the built in computername parameter (windows - dcom)
Get-Service -computerName WEB-Test