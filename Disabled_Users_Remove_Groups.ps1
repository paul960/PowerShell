$DisabledOU = "DistinguishedName of Disabled OU"
foreach($aduser in (get-aduser -filter "enabled -eq 'false'" -SearchBase $DisabledOU -Properties memberof)){
    $aduser.memberof |
    where name -ne 'domain users' |
    Remove-ADGroupMember -Members $aduser -Confirm:$false
}
