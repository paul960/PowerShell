# I am using the cmdlet Export-CSV so i don´t need a Headliner!
# $outstring =  "FileName|Location|Size|FileType|LastModifiedBy|WindowsModified|WindowsModified|WindowsCreatedBy|WindowsCreated|AccessedDate|MD5Hash"

#$filePath -join ""
#$outstring -join "|" >> $filePath
#$ec=@("*.docx","*.xlsx") # NEVER USED!
#$ErrorActionPreference= 'silentlycontinue' # Commented for debugging


$filePath = 'C:\temp\E_Drive.csv'
$FolderPath = 'E:\'
$Extension=""
$MD5Key=""
$hasher = [System.Security.Cryptography.HashAlgorithm]::Create("MD5")

# loop trough all Files with Pipeline
Get-ChildItem $FolderPath  -recurse | ForEach-Object {
    
    # The $_ represents the current Object in the pipeline!
    # This is a full bloen Object no Text (like in *nix Shells)!
    # So you can access all Properties and Method of the Object inside this ForEach-Object process!
      
    if ($_.PSIsContainer -eq $False)
    {

       Try {
           $inputStream = $_.OpenRead() 
           $hashBytes = $hasher.ComputeHash( $inputStream)
           $builder = New-Object System.Text.StringBuilder
           $hashBytes | Foreach-Object { [void] $builder.Append($_.ToString("X2")) }
           $MD5Key = $builder.ToString() 
           $Extension=$_.Extension
       }
       finally {
        $inputStream.close()
       }
       
    }
    else
    {
       $MD5Key = ""
       $Extension="Folder"
    }
    
    # Create an Custom-Object with the New-Object Cmdlet (Type of PSObject)
    # See: http://social.technet.microsoft.com/wiki/contents/articles/7804.powershell-creating-custom-objects-en-us.aspx
    # I do this because I use Export-CSV and I don´t have to mess arround with the Headline
    
    $psobj = New-Object -TypeName PSObject
    Add-Member -InputObject $psobj -MemberType NoteProperty -Name FileName -Value $_.Name
    Add-Member -InputObject $psobj -MemberType NoteProperty -Name Location -Value $_.Directory
    Add-Member -InputObject $psobj -MemberType NoteProperty -Name Size -Value $_.Length
    Add-Member -InputObject $psobj -MemberType NoteProperty -Name FileType -Value $Extension
    Add-Member -InputObject $psobj -MemberType NoteProperty -Name LastModifiedBy -Value ''
    Add-Member -InputObject $psobj -MemberType NoteProperty -Name Directory -Value ''
    Add-Member -InputObject $psobj -MemberType NoteProperty -Name ISDir -Value ''
    Add-Member -InputObject $psobj -MemberType NoteProperty -Name WindowsModified -Value $_.LastWriteTime
    Add-Member -InputObject $psobj -MemberType NoteProperty -Name WindowsCreatedBy -Value ''
    Add-Member -InputObject $psobj -MemberType NoteProperty -Name WindowsCreated -Value $_.CreationTime
    Add-Member -InputObject $psobj -MemberType NoteProperty -Name AccessedDate -Value $_.LastAccessTime
    Add-Member -InputObject $psobj -MemberType NoteProperty -Name MD5Hash -Value $MD5Key

    # Put Object into the output
    $psobj
    

}<# End of: Get-ChildItem ForEach-Object #> | Export-CSV $filePath -NoTypeInformation # Exporting the CSV
