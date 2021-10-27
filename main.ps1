Param(
    $eventChannel,
    $eventRecordID
)
$whitelist = (get-content -path .\whitelist.txt).split(',')

$theevent = Get-EventLog -LogName $eventChannel -Index $eventRecordID
$sourceip = $theevent.Message.Substring( $theevent.Message.IndexOf("Source Network Address:"), 50).split([string]::Empty)[3]

$account = $theevent.Message.Substring( $theevent.Message.IndexOf("Account For Which Logon Failed:"),100).split([string]::Empty)[16]


"---  $eventChannel $eventRecordID $sourceip $account---"| Out-File -FilePath C:\temp\log.txt -Append

if(!$whitelist.contains($account))
{
   "Creating Firewallrule..." | Out-File -FilePath C:\temp\log.txt -Append
   New-NetFirewallRule -DisplayName "Block scriptkiddie that tried log in as: $account" -Direction Inbound -Action Block -RemoteAddress $sourceip
    
}else {
   "Ignoring $account " | Out-File -FilePath C:\temp\log.txt -Append
}