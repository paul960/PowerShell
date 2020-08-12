param($result)
$thumbprint = $result.ManagedItem.CertificateThumbprintHash
Set-RDCertificate -Role RDRedirector -Thumbprint $thumbprint -Force
Set-RDCertificate -Role RDGateway -Thumbprint $thumbprint -Force
Set-RDCertificate -Role RDPublishing -Thumbprint $thumbprint -Force
Set-RDCertificate -Role RDWebAccess -Thumbprint $thumbprint -Force

Restart-Service TSGateway
Restart-Service SessionEnv
Restart-Service Tssdis
Restart-Service RDMS