$User = $env:USERNAME

$path = "\\fch-dcj-file-01\Redirected_Users\" + $User + "\*"
$Destination = "C:\Users\" + $User

Copy-Item -Path $path -Destination $Destination -Recurse

Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name 'Favorites' -value '%USERPROFILE%\Favorites'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name 'Desktop' -value '%USERPROFILE%\Desktop'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name 'My Music' -value '%USERPROFILE%\Music'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name 'My Pictures' -value '%USERPROFILE%\Pictures'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name 'My Video' -value '%USERPROFILE%\Videos'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name 'Personal' -value '%USERPROFILE%\Documents'

Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders' -Name 'Favorites' -value '%USERPROFILE%\Favorites'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders' -Name 'Desktop' -value '%USERPROFILE%\Desktop'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders' -Name 'My Music' -value '%USERPROFILE%\Music'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders' -Name 'My Pictures' -value '%USERPROFILE%\Pictures'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders' -Name 'My Video' -value '%USERPROFILE%\Videos'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders' -Name 'Personal' -value '%USERPROFILE%\Documents'
 

remove-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name '{0DDD015D-B06C-45D5-8C4C-F59713854639}' -ErrorAction SilentlyContinue
remove-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name '{35286A68-3C57-41A1-BBB1-0EAE73D76C95}' -ErrorAction SilentlyContinue
remove-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name '{754AC886-DF64-4CBA-86B5-F7FBF4FBCEF5}' -ErrorAction SilentlyContinue
remove-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name '{A0C69A99-21C8-4671-8703-7934162FCF1D}' -ErrorAction SilentlyContinue
remove-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name '{F42EE2D3-909F-4907-8871-4C22FC0BF756}' -ErrorAction SilentlyContinue

del /F /Q %APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*

logoff