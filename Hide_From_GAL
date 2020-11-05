$OU = "DistinguishedName for Disabled OU"
Get-ADUser `
 -Filter {(enabled -eq "false") -and (msExchHideFromAddressLists -notlike "*")} `
 -SearchBase $OU`
 -Properties msExchHideFromAddressLists | `
 Set-ADUser -Add @{msExchHideFromAddressLists="TRUE"}
