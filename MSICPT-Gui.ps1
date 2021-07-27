function Get-ScriptDirectory
{
<#
    .SYNOPSIS
        Get-ScriptDirectory returns the proper location of the script.
 
    .OUTPUTS
        System.String
   
    .NOTES
        Returns the correct path within a packaged executable.
#>
	[OutputType([string])]
	param ()
	if ($null -ne $hostinvocation)
	{
		$PSScriptRoot = Split-Path $hostinvocation.MyCommand.path
	}
	else
	{
		$PSScriptRoot = Split-Path $script:MyInvocation.MyCommand.Path
	}
}

$IntuneWinAppUtilPath = "$PSScriptRoot\IntuneWinAppUtil.exe"


$FRM_MSICPT_Load={
	#TODO: Initialize Form Controls here
	
}

$BTN_Source_Click={
	#TODO: Place custom script here
	
	$FD_Source.ShowDialog()
	$SourceFolder.Text = $FD_Source.SelectedPath
	$buttonReset.Enabled = $true
	$Setupfile.Enabled = $true
	$BTNSelectSetupFilename.Enabled = $true
}

$BTNSelectSetupFilename_Click = {
	#TODO: Place custom script here
	$OFD_Source.ShowDialog()
	$Setupfile.text = $OFD_Source.SafeFileName
	$BTN_Browse.Enabled = $true
	$CBQuiet.Enabled = $true
	$Output.Enabled = $true
}

$BTN_Browse_Click={
	#TODO: Place custom script here
	$FD_Output.ShowDialog()
	$Output.Text = $FD_Output.SelectedPath
	$BTN_Create_Intunewim.Enabled = $true
	
}

$buttonReset_Click={
	#TODO: Place custom script here
	$Output.Text = ""
	$Setupfile.Text = ""
	$SourceFolder.Text = ""
	$Setupfile.Enabled = $false
	$BTNSelectSetupFilename.Enabled = $false
	$BTN_Browse.Enabled = $false
	$CBQuiet.Checked = $false
	$CBQuiet.Enabled = $false
	$Output.Enabled = $false
	$BTN_Create_Intunewim.Enabled = $false
	$buttonReset.Enabled = $false
}


$BTN_Create_Intunewim_Click={
	#TODO: Place custom script here
	$filepath = $SourceFolder.text
	$filename = $Setupfile.text
	$outputpath = $Output.text
	
	if ($CBQuiet.Checked -eq $true)
	{
		$cmd = "$IntuneWinAppUtilPath -c `"$filepath`" -s `"$filename`" -o `"$outputpath`" -q"
		$runme = "Start-Process -filepath $($cmd) -wait -Verb runAs"
		Start-Process powershell.exe -WindowStyle Hidden -ArgumentList "$($cmd) -Verb runAs" -wait -Verbose
	}
	else
	{
		$cmd = "$IntuneWinAppUtilPath -c `"$filepath`" -s `"$filename`" -o `"$outputpath`" -q"
		$runme = "Start-Process -filepath $($cmd) -Verb runAs"
		Start-Process powershell.exe -WindowStyle Hidden -ArgumentList "$($cmd) -Verb runAs" -wait -Verbose
	}
	
}
