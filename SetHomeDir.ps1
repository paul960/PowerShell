<#
CREATOR:
Paul Sinchuk

DESCRIPTION:
Sets the home directory in AD and creates the folder with the correct permissions.

REQUIREMENTS:
1. Must be ran on a machine that can user the AD Module. 
2. A CSV file with the fields listed below
samaccountname
homedrive
homedirectory

VERSION:
1.0
#>

# Update this with the correct location and name of your CSV file
$Users = Import-Csv C:\scripts\homedirectory.csv


foreach ($User in $Users)
{

$AD_User = Get-ADUser $user.samaccountname -Properties *

Set-ADUser $User.samaccountname -HomeDrive $User.homedrive -HomeDirectory $User.homedirectory
New-Item -path $User.homedirectory -ItemType Directory -force

$acl = Get-Acl $User.homedirectory

$FileSystemRights = [System.Security.AccessControl.FileSystemRights]"Modify"
$AccessControlType = [System.Security.AccessControl.AccessControlType]::Allow
$InheritanceFlags = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit, ObjectInherit"
$PropagationFlags = [System.Security.AccessControl.PropagationFlags]"InheritOnly"

$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule ($AD_User.SID, $FileSystemRights, $InheritanceFlags, $PropagationFlags, $AccessControlType)
$acl.AddAccessRule($AccessRule)

Set-Acl -Path $User.homedirectory -AclObject $acl


}