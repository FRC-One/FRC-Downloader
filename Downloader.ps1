﻿Import-Module BitsTransfer

$P = Import-Csv -Path .\FRCSoftware2020.csv
$P | Format-Table

Write-Output " "
Write-Output " "
Write-Output " "
Write-Output " "
Write-Output " "
Write-Output " "
Write-Output " "
Write-Output " "
Write-Output "Downloading can take a while. Please wait."


ForEach ($entry in $P){

	
	$friendlyName = $entry.("FriendlyName")
	$fileName = $entry.("FileName")
	$zipped = $entry.("isZipped")

	$url = $entry.("URL")
	$output = "$PSScriptRoot\$fileName"
	Write-Output "Downloading $friendlyName"

	#Start-BitsTransfer -Source $url -Destination $output
	(New-Object System.Net.WebClient).DownloadFile($url, $output)

	If($zipped -eq "TRUE"){
		$unzipOutput = "$PSScriptRoot\$friendlyName"
		Write-Output "Expanding $friendlyName to $unzipOutput"

		Expand-Archive -LiteralPath $output -DestinationPath $unzipOutput
	}
	Write-Output "Finished $friendlyName"

}


