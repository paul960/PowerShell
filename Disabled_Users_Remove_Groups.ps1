foreach($aduser in (get-aduser -filter "enabled -eq 'false'" -Properties memberof)){
    $aduser.memberof |
    where name -ne 'domain users' |
    Remove-ADGroupMember -Members $aduser
}
