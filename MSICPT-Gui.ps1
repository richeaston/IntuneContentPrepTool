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
	#select source folder
	
	$FD_Source.ShowDialog()
	$SourceFolder.Text = $FD_Source.SelectedPath
	$buttonReset.Enabled = $true
	$Setupfile.Enabled = $true
	$BTNSelectSetupFilename.Enabled = $true
}

$BTNSelectSetupFilename_Click = {
	#select .exe
	$folder = $SourceFolder.Text
	$OFD_Source.ShowDialog()
	$Setupfile.text = $OFD_Source.SafeFileName
	$BTN_Browse.Enabled = $true
	$CBQuiet.Enabled = $true
	$CBall.Enabled = $true
	$Output.Enabled = $true
}

$BTN_Browse_Click={
	#select output path
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
	$CBall.Checked = $false
	$CBall.Enabled = $false
	$Output.Enabled = $false
	$BTN_Create_Intunewim.Enabled = $false
	$buttonReset.Enabled = $false
}


$BTN_Create_Intunewim_Click={
		
	$filepath = $SourceFolder.text
	$filename = $Setupfile.text
	$outputpath = $Output.text
	$quiet = 0
	$all = 0 
	if ($CBQuiet.CheckState -eq $true)
	{
		$quiet = 1
	}
	
	if ($CBall.CheckState -eq $true)
	{
		$all = 1
	}
	
	if ($quiet -eq 0 -and $all -eq 0)
	{
		$args = "-c `"$filepath`" -s `"$filename`" -o `"$outputpath`""
	}
	elseif ($quiet -eq 1 -and $all -eq 0)
	{
		$args = "-c `"$filepath`" -s `"$filename`" -o `"$outputpath`" -q"
	}
	Start-Process ".\IntuneWinAppUtil.exe" -WindowStyle Normal -ArgumentList $args -wait -Verbose
}
