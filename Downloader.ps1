Import-Module BitsTransfer

$P = Import-Csv -Path .\FRCSoftware2020.csv
$P | Format-Table


ForEach ($entry in $P){

	
	$friendlyName = $entry.("FriendlyName")
	$fileName = $entry.("FileName")
	$zipped = $entry.("isZipped")

	$url = $entry.("URL")
	$output = "$PSScriptRoot\$fileName"
	Write-Output "Downloading $friendlyName"

	Start-BitsTransfer -Source $url -Destination $output

	If($zipped -eq "TRUE"){
		$unzipOutput = "$PSScriptRoot\$friendlyName"
		Write-Output "Uncompressing $friendlyName to $unzipOutput"

		Expand-Archive -LiteralPath $output -DestinationPath $unzipOutput
	}
	Write-Output "Finished $friendlyName"

}



Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

