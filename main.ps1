Param(
    $eventChannel,
    $eventRecordID
)
$whitelist = (get-content -path .\whitetlist.txt).split(',')
if($null -eq $whitelist)
{
   $whitelist = [System.Collections.Generic.List[psobject]]::New()
}
$theevent = Get-WinEvent -LogName $eventChannel | where recordid -eq $eventRecordID  
$sourceip = $theevent.Message.Substring( $theevent.Message.IndexOf("Source Network Address:"), 50).split([string]::Empty)[3]
$account = $theevent.Message.Substring( $theevent.Message.IndexOf("Account For Which Logon Failed:"),100).split([string]::Empty)[16]
if(!$whitelist.contains($account))
{
	if($null -ne $sourceip -and $null -ne $account)
		{
			New-NetFirewallRule -DisplayName "Block scriptkiddie that tried log in as: $account" -Direction Inbound -Action Block -RemoteAddress $sourceip
		}

}