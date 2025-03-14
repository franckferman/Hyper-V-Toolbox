<#hyper-v_toolbox.ps1
Author:	Franck FERMAN - contact@franckferman.fr
Description: Hyper-V Toolbox is a PowerShell script for managing virtual machines with Hyper-V, inspired by Vagrant and Docker. 
Version: 3.0
#>

<#
.SYNOPSIS
Hyper-V Toolbox is a PowerShell script for managing virtual machines with Hyper-V.

.DESCRIPTION
Hyper-V Toolbox is a PowerShell script for managing virtual machines with Hyper-V, inspired by Vagrant and Docker.

.EXAMPLE
PS> Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force;.\hyper-v_toolbox.ps1
#>

[string]$script:Default_WindowTitle=$host.ui.RawUI.WindowTitle

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the Microsoft Windows iso download links block
 - - - - # - - - - # - - - - # - - - - #>

[string]$script:isoSrc_Microsoft_Windows_11_multiple_editions="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/ISO_images/Microsoft_Windows/Microsoft_Windows_11_multiple_editions.iso"

[string]$script:isoSrc_Microsoft_Windows_10_Entreprise_LTSC="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/ISO_images/Microsoft_Windows/Microsoft_Windows_10_Entreprise_LTSC.iso"
[string]$script:isoSrc_Microsoft_Windows_10_multiple_editions="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/ISO_images/Microsoft_Windows/Microsoft_Windows_10_multiple_editions.iso"

[string]$script:isoSrc_Microsoft_Windows_Server_2012="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/ISO_images/Microsoft_Windows/Microsoft_Windows_Server_2012.iso"
[string]$script:isoSrc_Microsoft_Windows_Server_2016="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/ISO_images/Microsoft_Windows/Microsoft_Windows_Server_2016.iso"
[string]$script:isoSrc_Microsoft_Windows_Server_2019="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/ISO_images/Microsoft_Windows/Microsoft_Windows_Server_2019.iso"
[string]$script:isoSrc_Microsoft_Windows_Server_2022="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/ISO_images/Microsoft_Windows/Microsoft_Windows_Server_2022.iso"

[string]$script:isoSrc_Base_Microsoft_Windows_10_Entreprise_LTSC="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/images/Microsoft_Windows/Base_Microsoft_Windows_10_Entreprise_LTSC.vhdx"
[string]$script:isoSrc_Base_Microsoft_Windows_10_Pro="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/images/Microsoft_Windows/Base_Microsoft_Windows_10_Pro.vhdx"

[string]$script:isoSrc_Base_Microsoft_Windows_Server_2016="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/images/Microsoft_Windows/Base_Microsoft_Windows_Server_2016.vhdx"
[string]$script:isoSrc_Base_Microsoft_Windows_Server_2019="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/images/Microsoft_Windows/Base_Microsoft_Windows_Server_2019.vhdx"
[string]$script:isoSrc_Base_Microsoft_Windows_Server_2022="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/images/Microsoft_Windows/Base_Microsoft_Windows_Server_2022.vhdx"

[string]$script:isoSrc_Base_GNU_Linux_Base_Debian="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/images/GNU_Linux/Base_Debian.vhdx"
[string]$script:isoSrc_Base_GNU_Linux_Base_Rocky_Linux="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/images/GNU_Linux/Base_Rocky_Linux.vhdx"
[string]$script:isoSrc_Base_GNU_Linux_Base_Ubuntu="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/images/GNU_Linux/Base_Ubuntu.vhdx"

[string]$script:isoSrc_Base_GNU_Linux_Base_Parrot_Security="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/images/GNU_Linux/Base_Parrot_Security.vhdx"

<# - - - - # - - - - # - - - - # - - - - #
End of the Microsoft Windows iso download links block
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the Microsoft Windows preconfigured iso download links block
 - - - - # - - - - # - - - - # - - - - #>

[string]$script:isoSrc_preconfigured_base_Microsoft_Windows_10_Entreprise_LTSC="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/images/Microsoft_Windows/base-Microsoft_Windows_10_Entreprise_LTSC.vhdx"
[string]$script:isoSrc_preconfigured_base_Microsoft_Windows_10_Pro="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/images/Microsoft_Windows/base-Microsoft_Windows_10_Pro.vhdx"

<# - - - - # - - - - # - - - - # - - - - #
End of the Microsoft Windows preconfigured iso download links block
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the GNU/Linux iso download links block
 - - - - # - - - - # - - - - # - - - - #>

[string]$script:isoSrc_GNU_Linux_pfSense="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/ISO_images/GNU_Linux/GNU_Linux_pfSense.iso"

[string]$script:isoSrc_GNU_Linux_Debian="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/ISO_images/GNU_Linux/GNU_Linux_Debian.iso"
[string]$script:isoSrc_GNU_Linux_CentOS="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/ISO_images/GNU_Linux/GNU_Linux_CentOS.iso"
[string]$script:isoSrc_GNU_Linux_Rocky_Linux="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/ISO_images/GNU_Linux/GNU_Linux_Rocky_Linux.iso"
[string]$script:isoSrc_GNU_Linux_Ubuntu="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/ISO_images/GNU_Linux/GNU_Linux_Ubuntu.iso"

[string]$script:isoSrc_GNU_Linux_Parrot_Security="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/ISO_images/GNU_Linux/GNU_Linux_Parrot_Security.iso"
[string]$script:isoSrc_GNU_Linux_Kali_Linux="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/ISO_images/GNU_Linux/GNU_Linux_Kali_Linux.iso"

[string]$script:isoSrc_GNU_Linux_Tails="https://depository.fra1.digitaloceanspaces.com/Hyper-V_Toolbox/ISO_images/GNU_Linux/GNU_Linux_Tails.iso"

<# - - - - # - - - - # - - - - # - - - - #
End of the Microsoft GNU/Linux iso download links block
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the New_preconfigured_VM block  
 - - - - # - - - - # - - - - # - - - - #>

function Check_Administrator_Rights{
[bool]$is_it_Administrator=(New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
	switch($is_it_Administrator){
    	$True{main}
    	$False{Write-Host "Permission error, run the script with Administrator rights." -ForegroundColor darkred;exit}
    	default{Write-Host "An unexpected error was caused." -ForegroundColor darkred;exit}
	}
}

function Ask_YesOrNo{
	Param
    (
    	[string]$title,
		[string]$message
    )

    $choiceYes=New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","Yes"
    $choiceNo=New-Object System.Management.Automation.Host.ChoiceDescription "&No","No"
    $options=[System.Management.Automation.Host.ChoiceDescription[]]($choiceYes,$choiceNo)
    [int]$script:Ask_YesOrNo_Result=$host.ui.PromptForChoice($title,$message,$options,1)
}

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the LocalRessources_management block  
 - - - - # - - - - # - - - - # - - - - #>

function LocalRessources_management
{
Clear-Host
Write-Host "1 - Download all the resources ("-NoNewLine;Write-Host "long waiting times and large resources"-NoNewLine -ForegroundColor red;Write-Host ").`n"
Write-Host "2 - Download resources for creating Microsoft Windows virtual machines only."
Write-Host "3 - Download resources for creating GNU/Linux virtual machines only.`n"
Write-Host "4 - Interactive and personalized download of resources (" -NoNewLine;Write-Host "recommended" -NoNewLine -ForegroundColor green;Write-Host ").`n"
Write-Host "0 - Back to the main menu" -ForegroundColor darkred
Write-Host ""

[int]$user_choice=Read-Host "Your choice"
	switch($user_choice)
	{
    	1{LocalRessources_management_DL_all}
    	2{LocalRessources_management_DL_Microsoft_Windows}
    	3{LocalRessources_management_DL_GNU_Linux}
    	4{LocalRessources_management_DL_custom}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function Download_Image
{
	Param
    (
    	[string]$isoPath,
		[string]$isoDest,
		[string]$isoFolderPath,
		[string]$isoSrc
    )

Write-Host "Ongoing action: " -NoNewLine;Write-Host "Verification of required resources (and automatic decision making)."
	if(Test-Path $isoPath){Write-Host "Info: "-NoNewLine;Write-Host "The resource corresponding to your request has been identified"-ForegroundColor green -NoNewLine;Write-Host "."}else{
		Write-Host "Info: " -NoNewLine;Write-Host "The corresponding resource could not be identified or an unexpected error was caused during the identification phase." -ForegroundColor darkred
		Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Automated launch of the download of the corresponding resources.`n"-NoNewLine

			if(Test-Path $isoDest){$null}else{[void](New-Item -Path $isoFolderPath -ItemType Directory -Force)}

	Start-BitsTransfer -Source $isoSrc -Destination $isoDest -DisplayName "Hyper-V_Toolbox - Downloading function - Franck FERMAN." -Description "Download of the corresponding resource in progress."

	if(Test-Path $isoPath){Write-Host "Info: " -NoNewLine;Write-Host "Download successfully completed"-NoNewLine -ForegroundColor green;Write-Host "."}else{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused." -ForegroundColor darkred;Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor darkred;pause;main}
	}
}

function LocalRessources_management_DL_all
{
Clear-Host
Write-Host "Launching the resource download."

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Microsoft Windows 11 multiple editions "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\clients\iso\Microsoft_Windows_11_multiple_editions.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "isoSrc_Microsoft_Windows_11_multiple_editions"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Microsoft Windows 10 Entreprise LTSC "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\clients\iso\Microsoft_Windows_10_Entreprise_LTSC.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "isoSrc_Microsoft_Windows_10_Entreprise_LTSC"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Microsoft Windows 10 multiple editions "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\clients\iso\Microsoft_Windows_10_multiple_editions.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "isoSrc_Microsoft_Windows_10_multiple_editions"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Microsoft Windows Server 2012 "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2012.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "isoSrc_Microsoft_Windows_Server_2012"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Microsoft Windows Server 2016 "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2016.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "isoSrc_Microsoft_Windows_Server_2016"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Microsoft Windows Server 2019 "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2019.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "isoSrc_Microsoft_Windows_Server_2019"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Microsoft Windows Server 2022 "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2022.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "isoSrc_Microsoft_Windows_Server_2022"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Base for Microsoft Windows 10 Entreprise LTSC "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\clients\iso\Microsoft_Windows_10_Entreprise_LTSC.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "isoSrc_base_Microsoft_Windows_10_Entreprise_LTSC"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Base for Microsoft Windows 10 Pro "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\clients\iso\Microsoft_Windows_10_Pro.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "isoSrc_base_Microsoft_Windows_10_Pro"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Base for Microsoft Windows Server 2016 "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2016.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "isoSrc_base_Microsoft_Windows_Server_2016"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Base for Microsoft Windows Server 2019 "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2019.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "isoSrc_base_Microsoft_Windows_Server_2019"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Base for Microsoft Windows Server 2022 "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2022.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "isoSrc_base_Microsoft_Windows_Server_2022"

Write-Host "`nLaunching the GNU/Linux resource download."

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "GNU/Linux pfSense "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\GNU_Linux\iso\GNU_Linux_pfSense.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "isoSrc_GNU_Linux_pfSense"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "GNU/Linux Debian "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Debian.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "isoSrc_GNU_Linux_Debian"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "GNU/Linux CentOS "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\GNU_Linux\iso\GNU_Linux_CentOS.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "isoSrc_GNU_Linux_CentOS"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "GNU/Linux Rocky Linux "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Rocky_Linux.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "isoSrc_GNU_Linux_Rocky_Linux"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "GNU/Linux Ubuntu "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Ubuntu.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "isoSrc_GNU_Linux_Ubuntu"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "GNU/Linux Parrot Security "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Parrot_Security.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "isoSrc_GNU_Linux_Parrot_Security"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "GNU/Linux Kali Linux "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Kali_Linux.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "isoSrc_GNU_Linux_Kali_Linux"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "GNU/Linux Tails "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Tails.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "isoSrc_GNU_Linux_Tails"

Write-Host "`n9 - Back to the management of local resources menu"-ForegroundColor red
Write-Host "0 - Back to the main menu`n"-ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{   
    	9{LocalRessources_management}
    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function LocalRessources_management_DL_Microsoft_Windows
{
Clear-Host
Write-Host "Launching the resource download."

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Microsoft Windows 11 multiple editions "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\clients\iso\Microsoft_Windows_11_multiple_editions.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "isoSrc_Microsoft_Windows_11_multiple_editions"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Microsoft Windows 10 Entreprise LTSC "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\clients\iso\Microsoft_Windows_10_Entreprise_LTSC.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "isoSrc_Microsoft_Windows_10_Entreprise_LTSC"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Microsoft Windows 10 multiple editions "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\clients\iso\Microsoft_Windows_10_multiple_editions.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "isoSrc_Microsoft_Windows_10_multiple_editions"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Microsoft Windows Server 2012 "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2012.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "isoSrc_Microsoft_Windows_Server_2012"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Microsoft Windows Server 2016 "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2016.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "isoSrc_Microsoft_Windows_Server_2016"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Microsoft Windows Server 2019 "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2019.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "isoSrc_Microsoft_Windows_Server_2019"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Microsoft Windows Server 2022 "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2022.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "isoSrc_Microsoft_Windows_Server_2022"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Base for Microsoft Windows 10 Entreprise LTSC "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\clients\iso\Microsoft_Windows_10_Entreprise_LTSC.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "isoSrc_base_Microsoft_Windows_10_Entreprise_LTSC"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Base for Microsoft Windows 10 Pro "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\clients\iso\Microsoft_Windows_10_Pro.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "isoSrc_base_Microsoft_Windows_10_Pro"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Base for Microsoft Windows Server 2016 "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2016.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "isoSrc_base_Microsoft_Windows_Server_2016"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Base for Microsoft Windows Server 2019 "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2019.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "isoSrc_base_Microsoft_Windows_Server_2019"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "Base for Microsoft Windows Server 2022 "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2022.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "isoSrc_base_Microsoft_Windows_Server_2022"

Write-Host "`n9 - Back to the management of local resources menu"-ForegroundColor red
Write-Host "0 - Back to the main menu`n"-ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{   
    	9{LocalRessources_management}
    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function LocalRessources_management_DL_GNU_Linux
{
Clear-Host
Write-Host "Launching the GNU/Linux resource download."

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "GNU/Linux pfSense "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\GNU_Linux\iso\GNU_Linux_pfSense.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "isoSrc_GNU_Linux_pfSense"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "GNU/Linux Debian "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Debian.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "isoSrc_GNU_Linux_Debian"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "GNU/Linux CentOS "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\GNU_Linux\iso\GNU_Linux_CentOS.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "isoSrc_GNU_Linux_CentOS"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "GNU/Linux Rocky Linux "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Rocky_Linux.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "isoSrc_GNU_Linux_Rocky_Linux"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "GNU/Linux Ubuntu "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Ubuntu.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "isoSrc_GNU_Linux_Ubuntu"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "GNU/Linux Parrot Security "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Parrot_Security.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "isoSrc_GNU_Linux_Parrot_Security"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "GNU/Linux Kali Linux "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Kali_Linux.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "isoSrc_GNU_Linux_Kali_Linux"

Write-Host "`nStart downloading the "-NoNewLine;Write-Host "GNU/Linux Tails "-ForegroundColor green -NoNewLine;Write-Host "image.`n"
Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Tails.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "isoSrc_GNU_Linux_Tails"

Write-Host "`n9 - Back to the management of local resources menu"-ForegroundColor red
Write-Host "0 - Back to the main menu`n"-ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{   
    	9{LocalRessources_management}
    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function LocalRessources_management_DL_custom
{
Clear-Host
Write-Host "Launching the custom download program."

Ask_YesOrNo "Question" "Would you like to install one or more Microsoft Windows machines?"
	switch($Ask_YesOrNo_Result)		## Begin Microsoft Windows block
	{
		1{[bool]$Use_Microsoft_Windows=$false}	
		0{[bool]$Use_Microsoft_Windows=$true		## Begin if Microsoft Windows is True

Ask_YesOrNo "Question" "Would you like to install Microsoft Windows 11 multiple editions?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_Microsoft_Windows_11_multiple_editions=$false}
		0{[bool]$Use_Microsoft_Windows_11_multiple_editions=$true}
	}

Ask_YesOrNo "Question" "Would you like to install Microsoft Windows 10 Entreprise LTSC?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_Microsoft_Windows_10_Entreprise_LTSC=$false}
		0{[bool]$Use_Microsoft_Windows_10_Entreprise_LTSC=$true}
	}

Ask_YesOrNo "Question" "Would you like to install Microsoft Windows 10 multiple editions?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_Microsoft_Windows_10_multiple_editions=$false}
		0{[bool]$Use_Microsoft_Windows_10_multiple_editions=$true}
	}

Ask_YesOrNo "Question" "Would you like to install Microsoft Windows Server 2012?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_Microsoft_Windows_Server_2012=$false}
		0{[bool]$Use_Microsoft_Windows_Server_2012=$true}
	}

Ask_YesOrNo "Question" "Would you like to install Microsoft Windows Server 2016?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_Microsoft_Windows_Server_2016=$false}
		0{[bool]$Use_Microsoft_Windows_Server_2016=$true}
	}

Ask_YesOrNo "Question" "Would you like to install Microsoft Windows Server 2019?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_Microsoft_Windows_Server_2019=$false}
		0{[bool]$Use_Microsoft_Windows_Server_2019=$true}
	}

Ask_YesOrNo "Question" "Would you like to install Microsoft Windows Server 2022?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_Microsoft_Windows_Server_2022=$false}
		0{[bool]$Use_Microsoft_Windows_Server_2022=$true}
	}

Ask_YesOrNo "Question" "Would you like to install Base for Microsoft Windows 10 Entreprise LTSC?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_Base_Microsoft_Windows_10_Entreprise_LTSC=$false}
		0{[bool]$Use_Base_Microsoft_Windows_10_Entreprise_LTSC=$true}
	}

Ask_YesOrNo "Question" "Would you like to install Base for Microsoft Windows 10 Pro?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_Base_Microsoft_Windows_10_Pro=$false}
		0{[bool]$Use_Base_Microsoft_Windows_10_Pro=$true}
	}

Ask_YesOrNo "Question" "Would you like to install Base for Microsoft Windows Server 2016?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_Base_Microsoft_Windows_Server_2016=$false}
		0{[bool]$Use_Base_Microsoft_Windows_Server_2016=$true}
	}

Ask_YesOrNo "Question" "Would you like to install Base for Microsoft Windows Server 2019?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_Base_Microsoft_Windows_Server_2019=$false}
		0{[bool]$Use_Base_Microsoft_Windows_Server_2019=$true}
	}

Ask_YesOrNo "Question" "Would you like to install Base for Microsoft Windows Server 2022?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_Base_Microsoft_Windows_Server_2022=$false}
		0{[bool]$Use_Base_Microsoft_Windows_Server_2022=$true}
	}
}		## End if Microsoft Windows is True
	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
}		## End Microsoft Windows block

Ask_YesOrNo "Question" "Would you like to install one or more GNU/Linux machines?"
	switch($Ask_YesOrNo_Result)		## Begin GNU/Linux block
	{
		1{[bool]$Use_GNU_Linux=$false}	
		0{[bool]$Use_GNU_Linux=$true		## Begin if GNU/Linux is True

Ask_YesOrNo "Question" "Would you like to install GNU/Linux pfSense?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_GNU_Linux_pfSense=$false}
		0{[bool]$Use_GNU_Linux_pfSense=$true}
	}

Ask_YesOrNo "Question" "Would you like to install GNU/Linux Debian?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_GNU_Linux_Debian=$false}
		0{[bool]$Use_GNU_Linux_Debian=$true}
	}

Ask_YesOrNo "Question" "Would you like to install GNU/Linux CentOS?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_GNU_Linux_CentOS=$false}
		0{[bool]$Use_GNU_Linux_CentOS=$true}
	}

Ask_YesOrNo "Question" "Would you like to install GNU/Linux Rocky_Linux?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_GNU_Linux_Rocky_Linux=$false}
		0{[bool]$Use_GNU_Linux_Rocky_Linux=$true}
	}

Ask_YesOrNo "Question" "Would you like to install GNU/Linux Ubuntu?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_GNU_Linux_Ubuntu=$false}
		0{[bool]$Use_GNU_Linux_Ubuntu=$true}
	}

Ask_YesOrNo "Question" "Would you like to install GNU/Linux Parrot_Security?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_GNU_Linux_Parrot_Security=$false}
		0{[bool]$Use_GNU_Linux_Parrot_Security=$true}
	}

Ask_YesOrNo "Question" "Would you like to install GNU/Linux Kali_Linux?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_GNU_Linux_Kali_Linux=$false}
		0{[bool]$Use_GNU_Linux_Kali_Linux=$true}
	}

Ask_YesOrNo "Question" "Would you like to install GNU/Linux Tails?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_GNU_Linux_Tails=$false}
		0{[bool]$Use_GNU_Linux_Tails=$true}
	}

Ask_YesOrNo "Question" "Would you like to install Base for GNU/Linux Debian?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_Base_GNU_Linux_Debian=$false}
		0{[bool]$Use_Base_GNU_Linux_Debian=$true}
	}

Ask_YesOrNo "Question" "Would you like to install Base for GNU/Linux Rocky Linux?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_Base_GNU_Linux_Rocky_Linux=$false}
		0{[bool]$Use_Base_GNU_Linux_Rocky_Linux=$true}
	}

Ask_YesOrNo "Question" "Would you like to install Base for GNU/Linux Ubuntu?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_Base_GNU_Linux_Ubuntu=$false}
		0{[bool]$Use_Base_GNU_Linux_Ubuntu=$true}
	}

Ask_YesOrNo "Question" "Would you like to install Base for GNU/Linux Parrot Security?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$Use_Base_GNU_Linux_Parrot_Security=$false}
		0{[bool]$Use_Base_GNU_Linux_Parrot_Security=$true}
	}
}		## End if GNU/Linux is True
	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
}		## End GNU/Linux block

if($Use_Microsoft_Windows_11_multiple_editions -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Microsoft Windows Entreprise ISO download process.`n";Download_Image ".\src\Microsoft_Windows\clients\iso\Microsoft_Windows_11_multiple_editions.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "$isoSrc_Microsoft_Windows_11_multiple_editions"}else{$null}

if($Use_Microsoft_Windows_10_Entreprise_LTSC -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Microsoft Windows 10 Entreprise LTSC download process.`n";Download_Image ".\src\Microsoft_Windows\clients\iso\Microsoft_Windows_10_Entreprise_LTSC.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "$isoSrc_Microsoft_Windows_10_Entreprise_LTSC"}else{$null}

if($Use_Microsoft_Windows_10_multiple_editions -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Microsoft Windows 10 multiple editions download process.`n";Download_Image ".\src\Microsoft_Windows\clients\iso\Microsoft_Windows_10_multiple_editions.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "$isoSrc_Microsoft_Windows_10_multiple_editions"}else{$null}

if($Use_Microsoft_Windows_Server_2012 -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Microsoft Windows Server 2012 download process.`n";Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2012.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "$isoSrc_Microsoft_Windows_Server_2012"}else{$null}

if($Use_Microsoft_Windows_Server_2016 -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Microsoft Windows Server 2016 download process.`n";Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2016.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "$isoSrc_Microsoft_Windows_Server_2016"}else{$null}

if($Use_Microsoft_Windows_Server_2019 -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Microsoft Windows Server 2019 download process.`n";Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2019.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "$isoSrc_Microsoft_Windows_Server_2019"}else{$null}

if($Use_Microsoft_Windows_Server_2022 -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Microsoft Windows Server 2022 download process.`n";Download_Image ".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2022.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "$isoSrc_Microsoft_Windows_Server_2022"}else{$null}

if($Use_GNU_Linux_pfSense -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the GNU/Linux pfSense download process.`n";Download_Image ".\src\GNU_Linux\iso\GNU_Linux_pfSense.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "$isoSrc_GNU_Linux_pfSense"}else{$null}

if($Use_GNU_Linux_Debian -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the GNU/Linux Debian download process.`n";Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Debian.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "$isoSrc_GNU_Linux_Debian"}else{$null}

if($Use_GNU_Linux_CentOS -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the GNU/Linux CentOS download process.`n";Download_Image ".\src\GNU_Linux\iso\GNU_Linux_CentOS.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "$isoSrc_GNU_Linux_CentOS"}else{$null}

if($Use_GNU_Linux_Rocky_Linux -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the GNU/Linux Rocky_Linux download process.`n";Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Rocky_Linux.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "$isoSrc_GNU_Linux_Rocky_Linux"}else{$null}

if($Use_GNU_Linux_Ubuntu -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the GNU/Linux Ubuntu download process.`n";Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Ubuntu.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "$isoSrc_GNU_Linux_Ubuntu"}else{$null}

if($Use_GNU_Linux_Parrot_Security -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the GNU/Linux Parrot_Security download process.`n";Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Parrot_Security.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "$isoSrc_GNU_Linux_Parrot_Security"}else{$null}

if($Use_GNU_Linux_Kali_Linux -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the GNU/Linux Kali_Linux download process.`n";Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Kali_Linux.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "$isoSrc_GNU_Linux_Kali_Linux"}else{$null}

if($Use_GNU_Linux_Tails -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the GNU/Linux Tails download process.`n";Download_Image ".\src\GNU_Linux\iso\GNU_Linux_Tails.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "$isoSrc_GNU_Linux_Tails"}else{$null}

Write-Host "`n9 - Back to the local ressources management menu"-ForegroundColor red
Write-Host "0 - Back to the main menu`n"-ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{   
    	9{LocalRessources_management}
    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

 <# - - - - # - - - - # - - - - # - - - - #
End of the LocalRessources_management block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the VirtualSwitch_management block  
 - - - - # - - - - # - - - - # - - - - #>

function Remove_VirtualSwitch
{
Clear-Host
Write-Host "List of virtual switches:`n"

$Get_Switches=Get-VMSwitch
if($Get_Switches -eq $null){Write-Host "Info: "-NoNewLine;Write-Host "No available switches detected."-ForegroundColor darkred;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the virtual switches management menu.`n`n" -ForegroundColor red;pause;VirtualSwitch_management}

[array]$VirtualSwitches=@()
$Get_Switches|ForEach-Object{$VirtualSwitches+=$_.Name}

For($i=0;$i -lt $VirtualSwitches.Length;$i++){Write-Host "$i - $($VirtualSwitches[$i])"}

$userchoice=Read-Host "`nWhich virtual switch do you want to remove"
$VirtualSwitchChoice=$VirtualSwitches[$userchoice]
$Selected_Switch=$VirtualSwitchChoice
Write-Host "`nInfo: " -NoNewLine;Write-Host "The chosen virtual switch is " -NoNewLine;Write-Host "$Selected_Switch" -NoNewLine -ForegroundColor green;Write-Host "."
Write-Host "Ongoing action: " -NoNewLine;Write-Host "Deletion of the virtual switch " -NoNewLine;Write-Host "$Selected_Switch" -NoNewLine -ForegroundColor green;Write-Host "."
Remove-VMSwitch -Name $Selected_Switch -Force

Write-Host "`n8 - Delete another virtual switch"
Write-Host "`n9 - Back to the virtual switches management menu"-ForegroundColor red
Write-Host "0 - Back to the main menu`n"-ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{   
    	8{Remove_VirtualSwitch}
    	9{VirtualSwitch_management}
    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function New_VirtualSwitch
{
Clear-Host
$Switch_Name=Read-Host "What is the name you want to give to your virtual switch"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for your virtual switch is " -NoNewLine;Write-Host "$Switch_Name" -NoNewLine -ForegroundColor green;Write-Host ".`n"

Write-Host "What type of virtual switch do you want to create?`n"
Write-Host "1 - Internal : Allows communication between virtual machines on the same Hyper-V server, and between the virtual machines and the management host operating system."
Write-Host "2 - Private : Only allows communication between virtual machines on the same Hyper-V server. A private network is isolated from all external network traffic on the Hyper-V server. This type of network is useful when you must create an isolated networking environment, like an isolated test domain.`n"

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
		1{[string]$Switch_Type="Internal"}
		2{[string]$Switch_Type="Private"}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}

New-VMSwitch -Name $Switch_Name -SwitchType $Switch_Type|Out-Null

Write-Host "`n9 - Back to the virtual switches management menu"-ForegroundColor red
Write-Host "0 - Back to the main menu`n"-ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{   
    	9{VirtualSwitch_management}
    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function Show_VirtualSwitch
{
Clear-Host
Write-Host "List of virtual switches:`n"

Get-VMSwitch|Out-Default

Write-Host "9 - Back to the virtual switches management menu"-ForegroundColor red
Write-Host "0 - Back to the main menu`n"-ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{   
    	9{VirtualSwitch_management}
    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function VirtualSwitch_management{
Clear-Host
Write-Host "1 - Display the list of virtual switches`n"
Write-Host "2 - Virtual switch creation"
Write-Host "3 - Virtual switch removal`n"
Write-Host "0 - Back to the main menu`n" -ForegroundColor darkred

[int]$user_choice=Read-Host "Your choice"
	switch($user_choice)
	{
    	1{Show_VirtualSwitch}
    	2{New_VirtualSwitch}
    	3{Remove_VirtualSwitch}
    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

 <# - - - - # - - - - # - - - - # - - - - #
End of the VirtualSwitch_management block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the VM_management block  
 - - - - # - - - - # - - - - # - - - - #>

function Remove_all_VMs
{
Clear-Host
Write-Host "Recovery of virtual machine data.`n`n"
$Get_VM=Get-VM
if($Get_VM -eq $null){Write-Host "Info: "-NoNewLine;Write-Host "No available machines detected."-ForegroundColor darkred;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the virtual machine management menu.`n`n" -ForegroundColor red;pause;VM_management}

[array]$VMsList=@()
$Get_VM|ForEach-Object{$VMsList+=$_.Name}
ForEach($VM in $VMsList){Write-Host "Identification and selection of the virtual machine named "-NoNewLine;Write-Host "$VM"-ForegroundColor green -NoNewLine;Write-Host ".";if((Get-VM -Name $VM).State -eq "Running"){Write-Host "Shut down the virtual machine.";Stop-VM -Name $VM -ErrorAction SilentlyContinue -TurnOff -Force};Write-Host "Remove of the virtual machine.`n";Remove-VM -Name $VM -Force}

[array]$VHDXList=@()
$VHDXPath=Get-ChildItem -Path . -Filter *.vhdx -Recurse -Exclude base-*|%{$_.FullName}
$VHDXList=$VHDXPath
ForEach($VHDX in $VHDXList){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Deletion of the virtual hard disk " -NoNewLine;Write-Host "$VHDX" -ForegroundColor green -NoNewLine;Write-Host ".";[void](Remove-Item -Path $VHDX -Force -Recurse)}

[void](Remove-Item -Path ".\src\Microsoft_Windows\clients\vms\*" -Force -Recurse -ErrorAction SilentlyContinue -WarningAction SilentlyContinue -InformationAction SilentlyContinue)
[void](Remove-Item -Path ".\src\Microsoft_Windows\servers\vms\*" -Force -Recurse -ErrorAction SilentlyContinue -WarningAction SilentlyContinue -InformationAction SilentlyContinue)
[void](Remove-Item -Path ".\src\GNU_Linux\vms\*" -Force -Recurse -ErrorAction SilentlyContinue -WarningAction SilentlyContinue -InformationAction SilentlyContinue)

Write-Host "`n9 - Back to the virtual machine management menu"-ForegroundColor red
Write-Host "0 - Back to the main menu`n"-ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{   
    	9{VM_management}
    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function Remove_VMs
{
Clear-Host
Write-Host "List of virtual machines:`n"

$Get_VM=Get-VM
if($Get_VM -eq $null){Write-Host "Info: "-NoNewLine;Write-Host "No available machines detected."-ForegroundColor darkred;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the virtual machine management menu.`n" -ForegroundColor red;pause;VM_management}
[array]$VMsList=@()
$Get_VM|ForEach-Object{$VMsList+=$_.Name}
For($i=0;$i -lt $VMsList.Length;$i++){Write-Host "$i - $($VMsList[$i])"}
Write-Host "`n99 - Cancel and return to the virtual machine management menu"-ForegroundColor red
[int]$userchoice=Read-Host "`nSelect a virtual machine to remove"
if($userchoice -eq 99){VM_management}
$VMuserchoice=$VMsList[$userchoice]
$Selected_VM=$VMuserchoice
Write-Host "`nInfo: " -NoNewLine;Write-Host "The selected virtual machine is " -NoNewLine;Write-Host "$Selected_VM" -NoNewLine -ForegroundColor green;Write-Host "."
if((Get-VM -Name $Selected_VM).State -eq "Running"){Write-Host "Ongoing action: " -NoNewLine;Write-Host "Shut down of the virtual machine"-ForegroundColor green -NoNewLine;Write-Host ".";Stop-VM -Name $Selected_VM -ErrorAction SilentlyContinue -TurnOff -Force}
Write-Host "Ongoing action: " -NoNewLine;Write-Host "Removal of the virtual machine and their data"-ForegroundColor green -NoNewLine;Write-Host "."

Remove-VM -Name $Selected_VM -Force

$VMPath=Get-ChildItem -Path . -Filter $Selected_VM -Recurse|%{$_.FullName}
[void](Remove-Item -Path $VMPath -Force -Recurse)

$Selected_VHDX=$Selected_VM+".vhdx"
$VHDXPath=Get-ChildItem -Path . -Filter $Selected_VHDX -Recurse|%{$_.FullName}
[void](Remove-Item -Path $VHDXPath -Force -Recurse)

Write-Host "`n8 - Remove another virtual machine`n"
Write-Host "9 - Back to the virtual machine management menu"-ForegroundColor red
Write-Host "0 - Back to the main menu`n"-ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{   
		8{Remove_VMs}
    	9{VM_management}
    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function Shutdown_all_VMs
{
Clear-Host
Write-Host "Verification of powered virtual machines.`n`n"
$Get_powered_VM=Get-VM|Where{$_.State -eq 'Running'}
if($Get_powered_VM -eq $null){Write-Host "Info: "-NoNewLine;Write-Host "No available machines detected."-ForegroundColor darkred;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the virtual machine management menu.`n`n" -ForegroundColor red;pause;VM_management}

[array]$VMsList=@()
$Get_powered_VM|ForEach-Object{$VMsList+=$_.Name}
ForEach($VM in $VMsList){Write-Host "Identification and selection of the virtual machine named "-NoNewLine;Write-Host "$VM"-ForegroundColor green -NoNewLine;Write-Host ".";Write-Host "Shut down the virtual machine.";Stop-VM -Name $VM -ErrorAction SilentlyContinue -TurnOff -Force;Write-Host "`n"}

Write-Host "9 - Back to the virtual machine management menu"-ForegroundColor red
Write-Host "0 - Back to the main menu`n"-ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{   
    	9{VM_management}
    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function Shutdown_VMs
{
Clear-Host
Write-Host "List of powered virtual machines:`n"
$Get_powered_VM=Get-VM|Where{$_.State -eq 'Running'}
if($Get_powered_VM -eq $null){Write-Host "Info: "-NoNewLine;Write-Host "No available machines detected."-ForegroundColor darkred;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the virtual machine management menu.`n" -ForegroundColor red;pause;VM_management}

[array]$VMsList=@()
$Get_powered_VM|ForEach-Object{$VMsList+=$_.Name}
For($i=0;$i -lt $VMsList.Length;$i++){Write-Host "$i - $($VMsList[$i])"}
Write-Host "`n99 - Cancel and return to the virtual machine management menu"-ForegroundColor red
[int]$userchoice=Read-Host "`nSelect a virtual machine to start"
if($userchoice -eq 99){VM_management}
$VMuserchoice=$VMsList[$userchoice]
$Selected_VM=$VMuserchoice
Write-Host "`nInfo: " -NoNewLine;Write-Host "The selected virtual machine is " -NoNewLine;Write-Host "$Selected_VM" -NoNewLine -ForegroundColor green;Write-Host "."
Write-Host "Ongoing action: " -NoNewLine;Write-Host "Shut down of the virtual machine"-ForegroundColor green -NoNewLine;Write-Host "."
Stop-VM -Name $Selected_VM -ErrorAction SilentlyContinue -TurnOff -Force

Write-Host "`n8 - Shut down another virtual machine`n"
Write-Host "9 - Back to the virtual machine management menu"-ForegroundColor red
Write-Host "0 - Back to the main menu`n"-ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{   
		8{Shutdown_VMs}
    	9{VM_management}
    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function Startup_all_VMs
{
Clear-Host
Write-Host "Verification of unpowered virtual machines.`n`n"
$Get_unpowered_VM=Get-VM|Where{$_.State -eq 'Off'}
if($Get_unpowered_VM -eq $null){Write-Host "Info: "-NoNewLine;Write-Host "No available machines detected."-ForegroundColor darkred;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the virtual machine management menu.`n`n" -ForegroundColor red;pause;VM_management}

[array]$VMsList=@()
$Get_unpowered_VM|ForEach-Object{$VMsList+=$_.Name}
ForEach($VM in $VMsList){Write-Host "Identification and selection of the virtual machine named "-NoNewLine;Write-Host "$VM"-ForegroundColor green -NoNewLine;Write-Host ".";Write-Host "Starting the virtual machine.";Start-VM $VM;Write-Host "`n"}

Write-Host "9 - Back to the virtual machine management menu"-ForegroundColor red
Write-Host "0 - Back to the main menu`n"-ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{   
    	9{VM_management}
    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function Startup_VMs
{
Clear-Host
Write-Host "List of unpowered virtual machines:`n"
$Get_unpowered_VM=Get-VM|Where{$_.State -eq 'Off'}
if($Get_unpowered_VM -eq $null){Write-Host "Info: "-NoNewLine;Write-Host "No available machines detected."-ForegroundColor darkred;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the virtual machine management menu.`n" -ForegroundColor red;pause;VM_management}

[array]$VMsList=@()
$Get_unpowered_VM|ForEach-Object{$VMsList+=$_.Name}
For($i=0;$i -lt $VMsList.Length;$i++){Write-Host "$i - $($VMsList[$i])"}
Write-Host "`n99 - Cancel and return to the virtual machine management menu"-ForegroundColor red
[int]$userchoice=Read-Host "`nSelect a virtual machine to start"
if($userchoice -eq 99){VM_management}
$VMuserchoice=$VMsList[$userchoice]
$Selected_VM=$VMuserchoice
Write-Host "`nInfo: " -NoNewLine;Write-Host "The selected virtual machine is " -NoNewLine;Write-Host "$Selected_VM" -NoNewLine -ForegroundColor green;Write-Host "."
Write-Host "Ongoing action: " -NoNewLine;Write-Host "Start up of the virtual machine"-ForegroundColor green -NoNewLine;Write-Host "."
Start-VM -Name $Selected_VM

Write-Host "`n8 - Starting another virtual machine`n"
Write-Host "9 - Back to the virtual machine management menu"-ForegroundColor red
Write-Host "0 - Back to the main menu`n"-ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{   
		8{Startup_VMs}
    	9{VM_management}
    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function Show_VMs
{
Clear-Host
Write-Host "List of virtual machines:`n"

$Get_VM=Get-VM|Select-Object -Property Name,State,Uptime,Status
$Get_VM_Alt=Get-VM|Select-Object -Property Name,State,Status

$Get_State_VM=$Get_VM.State
ForEach ($VM in $Get_State_VM){if($VM -eq "Running"){$is_VM_Running=$True}}
if($is_VM_Running -eq $True){$Get_VM|Out-Default}elseif($is_VM_Running -ne $True){$Get_VM_Alt|Out-Default}

Write-Host "9 - Back to the virtual machine management menu"-ForegroundColor red
Write-Host "0 - Back to the main menu`n"-ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{   
    	9{VM_management}
    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function VM_management{
Clear-Host
Write-Host "1 - Display the list of virtual machines`n"
Write-Host "2 - Start up of specific virtual machines"
Write-Host "3 - Start all virtual machines`n"
Write-Host "4 - Shutting down of specific virtual machines"
Write-Host "5 - Shutting down all virtual machines`n"
Write-Host "6 - Deleting of specific virtual machines"
Write-Host "7 - Deleting all virtual machines`n"
Write-Host "0 - Back to the main menu`n" -ForegroundColor darkred

[int]$user_choice=Read-Host "Your choice"
	switch($user_choice)
	{
    	1{Show_VMs}
    	2{Startup_VMs}
    	3{Startup_all_VMs}
    	4{Shutdown_VMs}
    	5{Shutdown_all_VMs}
    	6{Remove_VMs}
    	7{Remove_all_VMs}
    
    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

 <# - - - - # - - - - # - - - - # - - - - #
End of the VM_management block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the Preconfigured_VM-Microsoft_Windows_Server_2016 block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_Different_preconfigured_VM-Microsoft_Windows_Server_2016
{
New_preconfigured_VM-Microsoft_Windows_Server_2016
}

function Copy_Same_preconfigured_VM-Microsoft_Windows_Server_2016{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_preconfigured_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_Same_preconfigured_VM-Microsoft_Windows_Server_2016}
    	2{Copy_Different_preconfigured_VM-Microsoft_Windows_Server_2016}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_preconfigured_VM-Microsoft_Windows_Server_2016
{
[string]$script:isoLocalPath=".\src\Microsoft_Windows\clients\vhds\base\base_client_Microsoft_Windows_10_Pro.vhdx"
[string]$script:isoDest=".\src\Microsoft_Windows\clients\vhds\base"
[string]$script:isoFolderPath=".\src\Microsoft_Windows\clients\vhds\base"
[string]$script:isoSrc=isoSrc_preconfigured_base_Microsoft_Windows_10_Pro

[string]$script:VHDSPath=".\src\Microsoft_Windows\clients\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\clients\vms\"

$script:RAMgbSize=2GB

New_preconfigured_VM_Template
New_preconfigured_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_Same_preconfigured_VM-Microsoft_Windows_Server_2016}
    	2{New_preconfigured_VM_Template}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the Preconfigured_VM-Microsoft_Windows_Server_2016 block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the Preconfigured_VM-Microsoft_Windows_10_Pro block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_Different_preconfigured_VM-Microsoft_Windows_10_Pro
{
New_preconfigured_VM-Microsoft_Windows_10_Pro
}

function Copy_Same_preconfigured_VM-Microsoft_Windows_10_Pro{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_preconfigured_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_Same_preconfigured_VM-Microsoft_Windows_10_Pro}
    	2{Copy_Different_preconfigured_VM-Microsoft_Windows_10_Pro}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_preconfigured_VM-Microsoft_Windows_10_Pro
{
[string]$script:isoLocalPath=".\src\Microsoft_Windows\clients\vhds\base\base_client_Microsoft_Windows_10_Pro.vhdx"
[string]$script:isoDest=".\src\Microsoft_Windows\clients\vhds\base"
[string]$script:isoFolderPath=".\src\Microsoft_Windows\clients\vhds\base"
[string]$script:isoSrc=isoSrc_preconfigured_base_Microsoft_Windows_10_Pro

[string]$script:VHDSPath=".\src\Microsoft_Windows\clients\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\clients\vms\"

$script:RAMgbSize=2GB

New_preconfigured_VM_Template
New_preconfigured_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_Same_preconfigured_VM-Microsoft_Windows_10_Pro}
    	2{New_preconfigured_VM_Template}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the Preconfigured_VM-Microsoft_Windows_10_Pro block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the Preconfigured_VM-Microsoft_Windows_10_Entreprise_LTSC block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_Different_preconfigured_VM-Microsoft_Windows_10_Entreprise_LTSC
{
New_preconfigured_VM-Microsoft_Windows_10_Entreprise_LTSC
}

function Copy_Same_preconfigured_VM-Microsoft_Windows_10_Entreprise_LTSC{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_preconfigured_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_Same_preconfigured_VM-Microsoft_Windows_10_Entreprise_LTSC}
    	2{Copy_Different_preconfigured_VM-Microsoft_Windows_10_Entreprise_LTSC}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_preconfigured_VM-Microsoft_Windows_10_Entreprise_LTSC
{
[string]$script:isoLocalPath=".\src\Microsoft_Windows\clients\vhds\base\base-Microsoft_Windows_10_Entreprise_LTSC.vhdx"
[string]$script:isoDest=".\src\Microsoft_Windows\clients\vhds\base"
[string]$script:isoFolderPath=".\src\Microsoft_Windows\clients\vhds\base"
[string]$script:isoSrc=isoSrc_preconfigured_base_Microsoft_Windows_10_Entreprise_LTSC

[string]$script:VHDSPath=".\src\Microsoft_Windows\clients\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\clients\vms\"

$script:RAMgbSize=2GB

New_preconfigured_VM_Template
New_preconfigured_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_Same_preconfigured_VM-Microsoft_Windows_10_Entreprise_LTSC}
    	2{New_preconfigured_VM_Template}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the Preconfigured_VM-Microsoft_Windows_10_Entreprise_LTSC block  
 - - - - # - - - - # - - - - # - - - - #>

function New_preconfigured_VM_Template_Microsoft_Windows{
New-VHD -ParentPath $isoLocalPath -Path $VHDSPath\$VMName.vhdx -Differencing|Out-Null

	if($UseNetworkCard -eq $true){[void](New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -BootDevice VHD -VHDPath $VHDSPath\$VMName.vhdx -Path "$vmsPath" -SwitchName $SwitchName)}else{[void](New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -BootDevice VHD -VHDPath "$VHDSPath\$VMName.vhdx" -Path "$vmsPath")}

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false
}

function New_preconfigured_VM_Template{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname"-NoNewLine -ForegroundColor green;Write-Host "."

Ask_YesOrNo "Hyper-V Toolbox - Message box function - Franck FERMAN." "Would you like to add a network card to your virtual machine?"
	switch($Ask_YesOrNo_Result){
		1{[bool]$script:UseNetworkCard=$False}

		0{
		[bool]$script:UseNetworkCard=$True
		[array]$VMsList=@()
		Get-VMSwitch|ForEach-Object{$VMsList+=$_.Name}
		Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Display the list of virtual switches.`n"
		For($i=0;$i -lt $VMsList.Length;$i++){Write-Host "$i - $($VMsList[$i])"}
		[int]$userchoice=Read-Host "`nWhich virtual switch do you want to set up on your virtual machine"
		[string]$VMchoice=$VMsList[$userchoice]
		[string]$script:SwitchName=$VMchoice
		Write-Host "Info: "-NoNewLine;Write-Host "The chosen virtual switch is "-NoNewLine;Write-Host "$SwitchName" -NoNewLine -ForegroundColor green;Write-Host "."
		}

    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}

Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Verification of required resources (and automatic decision making)."
	if(Test-Path $isoLocalPath){
		Write-Host "Info: "-NoNewLine;Write-Host "The resource corresponding to your request has been identified.`n" -ForegroundColor green
	}else{
		Write-Host "Info: "-NoNewLine;Write-Host "The corresponding resource could not be identified or an unexpected error was caused during the identification phase"-NoNewLine -ForegroundColor darkred;Write-Host "."
		Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Automated launch of the download of the corresponding resources.`n" -NoNewLine

	if(Test-Path $isoDest){$null}else{[void](New-Item -Path $isoFolderPath -ItemType Directory -Force)}

	Start-BitsTransfer -Source $isoSrc -Destination $isoDest -DisplayName "Hyper-V_Toolbox - Downloading function - Franck FERMAN."-Description "Download of the corresponding resource in progress."

	if(Test-Path $isoLocalPath){Write-Host "Info: " -NoNewLine;Write-Host "Download successfully completed.`n" -ForegroundColor green}else{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused." -ForegroundColor darkred;Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor darkred;pause;main}
	}

	if(Test-Path $VHDSPath){$null}else{[void](New-Item -Path $VHDSPath -ItemType Directory -Force)}
	if(Test-Path $vmsPath){$null}else{[void](New-Item -Path $vmsPath -ItemType Directory -Force)}
}

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the New_preconfigured_VM block  
 - - - - # - - - - # - - - - # - - - - #>

function New_preconfigured_VM-GNU_Linux{
Clear-Host
Write-Host "1 - Debian"
Write-Host "2 - Rocky Linux"
Write-Host "3 - Ubuntu`n"

Write-Host "4 - Parrot Security`n"

Write-Host "0 - Back to the main menu`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{New_preconfigured_VM-GNU_Linux_Debian}
    	2{New_preconfigured_VM-GNU_Linux_Rocky_Linux}
    	3{New_preconfigured_VM-GNU_Linux_Ubuntu}

    	4{New_preconfigured_VM-GNU_Linux_Parrot_Security}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function New_preconfigured_VM-Microsoft_Windows{
Clear-Host
Write-Host "1 - Microsoft Windows 10 Entreprise LTSC"
Write-Host "2 - Microsoft Windows 10 Pro`n"

Write-Host "3 - Microsoft Windows Server 2016"
Write-Host "4 - Microsoft Windows Server 2019"
Write-Host "5 - Microsoft Windows Server 2022`n"
Write-Host "0 - Back to the main menu`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{New_preconfigured_VM-Microsoft_Windows_10_Entreprise_LTSC}
    	2{New_preconfigured_VM-Microsoft_Windows_10_Multiple_Editions}

    	3{New_preconfigured_VM-Microsoft_Windows_10_Server_2016}
    	4{New_preconfigured_VM-Microsoft_Windows_10_Server_2019}
    	5{New_preconfigured_VM-Microsoft_Windows_10_Server_2022}

    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function New_preconfigured_VM{
Clear-Host
Write-Host "What type of operating system corresponds to the machine you want to generate?`n"
Write-Host "1 - Microsoft Windows"
Write-Host "2 - GNU/Linux`n"
Write-Host "0 - Back to the main menu`n" -ForegroundColor darkred

[int]$user_choice=Read-Host "Your choice"
	switch($user_choice)
	{
    	1{New_preconfigured_VM-Microsoft_Windows}
    	2{New_preconfigured_VM-GNU_Linux}
    
    	0{Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

 <# - - - - # - - - - # - - - - # - - - - #
End of the New_preconfigured_VM block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the GNU_Linux_Tails block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_VM_Different-GNU_Linux_Tails
{
New_blank_VM-GNU_Linux_Tails
}

function Copy_VM_Same-GNU_Linux_Tails{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_blank_VM_Template_GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-GNU_Linux_Tails}
    	2{Copy_VM_Different-GNU_Linux_Tails}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_blank_VM-GNU_Linux_Tails{
[string]$script:isoPath=".\src\GNU_Linux\iso\GNU_Linux_Tails.iso"
[string]$script:isoDest=".\src\GNU_Linux\iso"
[string]$script:isoFolderPath=".\src\GNU_Linux\iso"
[string]$script:isoSrc=$isoSrc_GNU_Linux_Tails

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

New_blank_VM_Template
New_blank_VM_Template_GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-GNU_Linux_Tails}
    	2{Copy_VM_Different-GNU_Linux_Tails}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the GNU_Linux_Tails block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the GNU_Linux_Kali_Linux block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_VM_Different-GNU_Linux_Kali_Linux
{
New_blank_VM-GNU_Linux_Kali_Linux
}

function Copy_VM_Same-GNU_Linux_Kali_Linux{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_blank_VM_Template_GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-GNU_Linux_Kali_Linux}
    	2{Copy_VM_Different-GNU_Linux_Kali_Linux}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_blank_VM-GNU_Linux_Kali_Linux{
[string]$script:isoPath=".\src\GNU_Linux\iso\GNU_Linux_Kali_Linux.iso"
[string]$script:isoDest=".\src\GNU_Linux\iso"
[string]$script:isoFolderPath=".\src\GNU_Linux\iso"
[string]$script:isoSrc=$isoSrc_GNU_Linux_Kali_Linux

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

New_blank_VM_Template
New_blank_VM_Template_GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-GNU_Linux_Kali_Linux}
    	2{Copy_VM_Different-GNU_Linux_Kali_Linux}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the GNU_Linux_Kali_Linux block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the GNU_Linux_Parrot_Security block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_VM_Different-GNU_Linux_Parrot_Security
{
New_blank_VM-GNU_Linux_Parrot_Security
}

function Copy_VM_Same-GNU_Linux_Parrot_Security{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_blank_VM_Template_GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-GNU_Linux_Parrot_Security}
    	2{Copy_VM_Different-GNU_Linux_Parrot_Security}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_blank_VM-GNU_Linux_Parrot_Security{
[string]$script:isoPath=".\src\GNU_Linux\iso\GNU_Linux_Parrot_Security.iso"
[string]$script:isoDest=".\src\GNU_Linux\iso"
[string]$script:isoFolderPath=".\src\GNU_Linux\iso"
[string]$script:isoSrc=$isoSrc_GNU_Linux_Parrot_Security

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

New_blank_VM_Template
New_blank_VM_Template_GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-GNU_Linux_Parrot_Security}
    	2{Copy_VM_Different-GNU_Linux_Parrot_Security}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the GNU_Linux_Parrot_Security block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the GNU_Linux_Ubuntu block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_VM_Different-GNU_Linux_Ubuntu
{
New_blank_VM-GNU_Linux_Ubuntu
}

function Copy_VM_Same-GNU_Linux_Ubuntu{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_blank_VM_Template_GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-GNU_Linux_Ubuntu}
    	2{Copy_VM_Different-GNU_Linux_Ubuntu}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_blank_VM-GNU_Linux_Ubuntu{
[string]$script:isoPath=".\src\GNU_Linux\iso\GNU_Linux_Ubuntu.iso"
[string]$script:isoDest=".\src\GNU_Linux\iso"
[string]$script:isoFolderPath=".\src\GNU_Linux\iso"
[string]$script:isoSrc=$isoSrc_GNU_Linux_Ubuntu

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

New_blank_VM_Template
New_blank_VM_Template_GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-GNU_Linux_Ubuntu}
    	2{Copy_VM_Different-GNU_Linux_Ubuntu}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the GNU_Linux_Ubuntu block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the GNU_Linux_Rocky_Linux block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_VM_Different-GNU_Linux_Rocky_Linux
{
New_blank_VM-GNU_Linux_Rocky_Linux
}

function Copy_VM_Same-GNU_Linux_Rocky_Linux{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_blank_VM_Template_GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-GNU_Linux_Rocky_Linux}
    	2{Copy_VM_Different-GNU_Linux_Rocky_Linux}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_blank_VM-GNU_Linux_Rocky_Linux{
[string]$script:isoPath=".\src\GNU_Linux\iso\GNU_Linux_Rocky_Linux.iso"
[string]$script:isoDest=".\src\GNU_Linux\iso"
[string]$script:isoFolderPath=".\src\GNU_Linux\iso"
[string]$script:isoSrc=$isoSrc_GNU_Linux_Rocky_Linux

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

New_blank_VM_Template
New_blank_VM_Template_GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-GNU_Linux_Rocky_Linux}
    	2{Copy_VM_Different-GNU_Linux_Rocky_Linux}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the GNU_Linux_Rocky_Linux block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the GNU_Linux_CentOS block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_VM_Different-GNU_Linux_CentOS
{
New_blank_VM-GNU_Linux_CentOS
}

function Copy_VM_Same-GNU_Linux_CentOS{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_blank_VM_Template_GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-GNU_Linux_CentOS}
    	2{Copy_VM_Different-GNU_Linux_CentOS}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_blank_VM-GNU_Linux_CentOS{
[string]$script:isoPath=".\src\GNU_Linux\iso\GNU_Linux_CentOS.iso"
[string]$script:isoDest=".\src\GNU_Linux\iso"
[string]$script:isoFolderPath=".\src\GNU_Linux\iso"
[string]$script:isoSrc=$isoSrc_GNU_Linux_CentOS

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

New_blank_VM_Template
New_blank_VM_Template_GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-GNU_Linux_CentOS}
    	2{Copy_VM_Different-GNU_Linux_CentOS}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the GNU_Linux_CentOS block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the GNU_Linux_Debian block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_VM_Different-GNU_Linux_Debian
{
New_blank_VM-GNU_Linux_Debian
}

function Copy_VM_Same-GNU_Linux_Debian{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_blank_VM_Template_GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-GNU_Linux_Debian}
    	2{Copy_VM_Different-GNU_Linux_Debian}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_blank_VM-GNU_Linux_Debian{
[string]$script:isoPath=".\src\GNU_Linux\iso\GNU_Linux_Debian.iso"
[string]$script:isoDest=".\src\GNU_Linux\iso"
[string]$script:isoFolderPath=".\src\GNU_Linux\iso"
[string]$script:isoSrc=$isoSrc_GNU_Linux_Debian

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

New_blank_VM_Template
New_blank_VM_Template_GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-GNU_Linux_Debian}
    	2{Copy_VM_Different-GNU_Linux_Debian}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the GNU_Linux_Debian block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the GNU_Linux_pfSense block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_VM_Different-GNU_Linux_pfSense
{
New_blank_VM-GNU_Linux_pfSense
}

function Copy_VM_Same-GNU_Linux_pfSense{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_blank_VM_Template_GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-GNU_Linux_pfSense}
    	2{Copy_VM_Different-GNU_Linux_pfSense}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_blank_VM-GNU_Linux_pfSense{
[string]$script:isoPath=".\src\GNU_Linux\iso\GNU_Linux_pfSense.iso"
[string]$script:isoDest=".\src\GNU_Linux\iso"
[string]$script:isoFolderPath=".\src\GNU_Linux\iso"
[string]$script:isoSrc=$isoSrc_GNU_Linux_pfSense

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

New_blank_VM_Template
New_blank_VM_Template_GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-GNU_Linux_pfSense}
    	2{Copy_VM_Different-GNU_Linux_pfSense}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the GNU_Linux_pfSense block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the Microsoft_Windows_Server_2022 block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_VM_Different-Microsoft_Windows_Server_2022
{
New_blank_VM-Microsoft_Windows_Server_2022
}

function Copy_VM_Same-Microsoft_Windows_Server_2022{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_blank_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-Microsoft_Windows_Server_2022}
    	2{Copy_VM_Different-Microsoft_Windows_Server_2022}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_blank_VM-Microsoft_Windows_Server_2022{
[string]$script:isoPath=".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2022.iso"
[string]$script:isoDest=".\src\Microsoft_Windows\servers\iso"
[string]$script:isoFolderPath=".\src\Microsoft_Windows\servers\iso"
[string]$script:isoSrc=$isoSrc_Microsoft_Windows_Server_2022

[string]$script:VHDSPath=".\src\Microsoft_Windows\servers\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\servers\vms\"

New_blank_VM_Template
New_blank_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-Microsoft_Windows_Server_2022}
    	2{Copy_VM_Different-Microsoft_Windows_Server_2022}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the Microsoft_Windows_Server_2022 block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the Microsoft_Windows_Server_2019 block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_VM_Different-Microsoft_Windows_Server_2019
{
New_blank_VM-Microsoft_Windows_Server_2019
}

function Copy_VM_Same-Microsoft_Windows_Server_2019{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_blank_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-Microsoft_Windows_Server_2019}
    	2{Copy_VM_Different-Microsoft_Windows_Server_2019}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_blank_VM-Microsoft_Windows_Server_2019{
[string]$script:isoPath=".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2019.iso"
[string]$script:isoDest=".\src\Microsoft_Windows\servers\iso"
[string]$script:isoFolderPath=".\src\Microsoft_Windows\servers\iso"
[string]$script:isoSrc=$isoSrc_Microsoft_Windows_Server_2019

[string]$script:VHDSPath=".\src\Microsoft_Windows\servers\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\servers\vms\"

New_blank_VM_Template
New_blank_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-Microsoft_Windows_Server_2019}
    	2{Copy_VM_Different-Microsoft_Windows_Server_2019}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the Microsoft_Windows_Server_2019 block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the Microsoft_Windows_Server_2016 block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_VM_Different-Microsoft_Windows_Server_2016
{
New_blank_VM-Microsoft_Windows_Server_2016
}

function Copy_VM_Same-Microsoft_Windows_Server_2016{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_blank_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-Microsoft_Windows_Server_2016}
    	2{Copy_VM_Different-Microsoft_Windows_Server_2016}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_blank_VM-Microsoft_Windows_Server_2016{
[string]$script:isoPath=".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2016.iso"
[string]$script:isoDest=".\src\Microsoft_Windows\servers\iso"
[string]$script:isoFolderPath=".\src\Microsoft_Windows\servers\iso"
[string]$script:isoSrc=$isoSrc_Microsoft_Windows_Server_2016

[string]$script:VHDSPath=".\src\Microsoft_Windows\servers\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\servers\vms\"

New_blank_VM_Template
New_blank_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-Microsoft_Windows_Server_2016}
    	2{Copy_VM_Different-Microsoft_Windows_Server_2016}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the Microsoft_Windows_Server_2016 block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the Microsoft_Windows_Server_2012 block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_VM_Different-Microsoft_Windows_Server_2012
{
New_blank_VM-Microsoft_Windows_Server_2012
}

function Copy_VM_Same-Microsoft_Windows_Server_2012{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_blank_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-Microsoft_Windows_Server_2012}
    	2{Copy_VM_Different-Microsoft_Windows_Server_2012}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_blank_VM-Microsoft_Windows_Server_2012{
[string]$script:isoPath=".\src\Microsoft_Windows\servers\iso\Microsoft_Windows_Server_2012.iso"
[string]$script:isoDest=".\src\Microsoft_Windows\servers\iso"
[string]$script:isoFolderPath=".\src\Microsoft_Windows\servers\iso"
[string]$script:isoSrc=$isoSrc_Microsoft_Windows_Server_2012

[string]$script:VHDSPath=".\src\Microsoft_Windows\servers\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\servers\vms\"

New_blank_VM_Template
New_blank_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-Microsoft_Windows_Server_2012}
    	2{Copy_VM_Different-Microsoft_Windows_Server_2012}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the Microsoft_Windows_Server_2012 block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the Microsoft_Windows_10_multiple_editions block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_VM_Different-Microsoft_Windows_10_multiple_editions
{
New_blank_VM-Microsoft_Windows_10_multiple_editions
}

function Copy_VM_Same-Microsoft_Windows_10_multiple_editions{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_blank_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-Microsoft_Windows_10_multiple_editions}
    	2{Copy_VM_Different-Microsoft_Windows_10_multiple_editions}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_blank_VM-Microsoft_Windows_10_multiple_editions{
[string]$script:isoPath=".\src\Microsoft_Windows\clients\iso\Microsoft_Windows_10_multiple_editions.iso"
[string]$script:isoDest=".\src\Microsoft_Windows\clients\iso"
[string]$script:isoFolderPath=".\src\Microsoft_Windows\clients\iso"
[string]$script:isoSrc=$isoSrc_Microsoft_Windows_10_multiple_editions

[string]$script:VHDSPath=".\src\Microsoft_Windows\clients\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\clients\vms\"

New_blank_VM_Template
New_blank_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-Microsoft_Windows_10_multiple_editions}
    	2{Copy_VM_Different-Microsoft_Windows_10_multiple_editions}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the Microsoft_Windows_10_multiple_editions block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the Microsoft_Windows_10_Entreprise_LTSC block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_VM_Different-Microsoft_Windows_10_Entreprise_LTSC
{
New_blank_VM-Microsoft_Windows_10_Entreprise_LTSC
}

function Copy_VM_Same-Microsoft_Windows_10_Entreprise_LTSC{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_blank_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-Microsoft_Windows_10_Entreprise_LTSC}
    	2{Copy_VM_Different-Microsoft_Windows_10_Entreprise_LTSC}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_blank_VM-Microsoft_Windows_10_Entreprise_LTSC{
[string]$script:isoPath=".\src\Microsoft_Windows\clients\iso\Microsoft_Windows_10_Entreprise_LTSC.iso"
[string]$script:isoDest=".\src\Microsoft_Windows\clients\iso"
[string]$script:isoFolderPath=".\src\Microsoft_Windows\clients\iso"
[string]$script:isoSrc=$isoSrc_Microsoft_Windows_10_Entreprise_LTSC

[string]$script:VHDSPath=".\src\Microsoft_Windows\clients\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\clients\vms\"

New_blank_VM_Template
New_blank_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-Microsoft_Windows_10_Entreprise_LTSC}
    	2{Copy_VM_Different-Microsoft_Windows_10_Entreprise_LTSC}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the Microsoft_Windows_10_Entreprise_LTSC block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the Microsoft_Windows_11_multiple_editions block  
 - - - - # - - - - # - - - - # - - - - #>

function Copy_VM_Different-Microsoft_Windows_11_multiple_editions
{
New_blank_VM-Microsoft_Windows_11_multiple_editions
}

function Copy_VM_Same-Microsoft_Windows_11_multiple_editions{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host ".`n"

New_blank_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-Microsoft_Windows_11_multiple_editions}
    	2{Copy_VM_Different-Microsoft_Windows_11_multiple_editions}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

function New_blank_VM-Microsoft_Windows_11_multiple_editions{
[string]$script:isoPath=".\src\Microsoft_Windows\clients\iso\Microsoft_Windows_11_multiple_editions.iso"
[string]$script:isoDest=".\src\Microsoft_Windows\clients\iso"
[string]$script:isoFolderPath=".\src\Microsoft_Windows\clients\iso"
[string]$script:isoSrc=$isoSrc_Microsoft_Windows_11_multiple_editions

[string]$script:VHDSPath=".\src\Microsoft_Windows\clients\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\clients\vms\"

New_blank_VM_Template
New_blank_VM_Template_Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics).`n"
Write-Host "0 - Go back to the main menu" -ForegroundColor red
Write-Host "9 - Quit the program`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{Copy_VM_Same-Microsoft_Windows_11_multiple_editions}
    	2{Copy_VM_Different-Microsoft_Windows_11_multiple_editions}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
    	9{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused."-ForegroundColor red;Write-Host "Ongoing action: "-NoNewLine;Write-Host "Go back to the main menu.`n"-ForegroundColor red;pause;main}
	}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the Microsoft_Windows_11_multiple_editions block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the New_blank_VM_Template_Microsoft_Windows block  
 - - - - # - - - - # - - - - # - - - - #>

function New_blank_VM_Template_Microsoft_Windows
{
	if($UseNetworkCard -eq $True){[void](New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName)}else{[void](New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath")}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False
}

<# - - - - # - - - - # - - - - # - - - - #
End of the New_blank_VM_Template_Microsoft_Windows block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the New_blank_VM_Template_GNU_Linux block  
 - - - - # - - - - # - - - - # - - - - #>

function New_blank_VM_Template_GNU_Linux
{
	if($UseNetworkCard -eq $True){[void](New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName)}else{[void](New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath")}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $False
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False
}

<# - - - - # - - - - # - - - - # - - - - #
End of the New_blank_VM_Template_GNU_Linux block  
 - - - - # - - - - # - - - - # - - - - #>

<# - - - - # - - - - # - - - - # - - - - #
Beginning of the New_blank_VM_Template block  
 - - - - # - - - - # - - - - # - - - - #>

function New_blank_VM_Template{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname"-NoNewLine -ForegroundColor green;Write-Host "."

Ask_YesOrNo "Hyper-V Toolbox - Message box function - Franck FERMAN." "Would you like to add a network card to your virtual machine?"
	switch($Ask_YesOrNo_Result){
		1{[bool]$script:UseNetworkCard=$False}

		0{
		[bool]$script:UseNetworkCard=$True
		[array]$VMsList=@()
		Get-VMSwitch|ForEach-Object{$VMsList+=$_.Name}
		Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Display the list of virtual switches.`n"
		For($i=0;$i -lt $VMsList.Length;$i++){Write-Host "$i - $($VMsList[$i])"}
		[int]$userchoice=Read-Host "`nWhich virtual switch do you want to set up on your virtual machine"
		[string]$VMchoice=$VMsList[$userchoice]
		[string]$script:SwitchName=$VMchoice
		Write-Host "Info: "-NoNewLine;Write-Host "The chosen virtual switch is "-NoNewLine;Write-Host "$SwitchName" -NoNewLine -ForegroundColor green;Write-Host "."
		}

    	default{Write-Host "`nInfo: "-NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}

Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Verification of required resources (and automatic decision making)."
	if(Test-Path $isoPath){
		Write-Host "Info: "-NoNewLine;Write-Host "The resource corresponding to your request has been identified." -ForegroundColor green
	}else{
		Write-Host "Info: "-NoNewLine;Write-Host "The corresponding resource could not be identified or an unexpected error was caused during the identification phase." -ForegroundColor darkred
		Write-Host "`nOngoing action: "-NoNewLine;Write-Host "Automated launch of the download of the corresponding resources.`n" -NoNewLine

	if(Test-Path $isoDest){$null}else{[void](New-Item -Path $isoFolderPath -ItemType Directory -Force)}

	Start-BitsTransfer -Source $isoSrc -Destination $isoDest -DisplayName "Hyper-V_Toolbox - Downloading function - Franck FERMAN."-Description "Download of the corresponding resource in progress."

	if(Test-Path $isoPath){Write-Host "Info: " -NoNewLine;Write-Host "Download successfully completed." -ForegroundColor green}else{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused." -ForegroundColor darkred;Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor darkred;pause;main}
	}

$RAMgbSizeList=@('1GB','2GB','4GB','8GB')
Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Display the list of choices concerning the available RAM on your virtual machine.`n"
For($i=0;$i -lt $RAMgbSizeList.Length;$i++){Write-Host "$i - $($RAMgbSizeList[$i])"}

[int]$userchoice=Read-Host "`nWhat quantity do you want to choose for your virtual machine"
$RAMgbSizeuserchoice=$RAMgbSizeList[$userchoice]
$RAMgbSize=$RAMgbSizeuserchoice
Write-Host "Info: " -NoNewLine;Write-Host "The chosen memory startup bytes is " -NoNewLine;Write-Host "$RAMgbSize" -NoNewLine -ForegroundColor green;Write-Host "."

    switch($RAMgbSize)
    {
        "1GB"{[Int64]$script:RAMgbSize=1GB}
        "2GB"{[Int64]$script:RAMgbSize=2GB}
        "4GB"{[Int64]$script:RAMgbSize=4GB}
        "8GB"{[Int64]$script:RAMgbSize=8GB}
    }

$VHDgbSizeList=@('16GB','20GB','32GB','48GB','64GB','80GB','120GB')
Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Display of the list of choices regarding the desired hard disk size for your virtual machine.`n"
For($i=0;$i -lt $VHDgbSizeList.Length;$i++){Write-Host "$i - $($VHDgbSizeList[$i])"}

[int]$userchoice=Read-Host "`nWhat size hard drive do you want for your virtual machine"
$VHDgbSizeuserchoice=$VHDgbSizeList[$userchoice]
$VHDgbSize=$VHDgbSizeuserchoice
Write-Host "Info: " -NoNewLine;Write-Host "The chosen hard disk size is " -NoNewLine;Write-Host "$VHDgbSize" -NoNewLine -ForegroundColor green;Write-Host ".`n"

    switch($VHDgbSize)
    {
        "16GB"{[Int64]$script:VHDgbSize=16GB}
        "20GB"{[Int64]$script:VHDgbSize=20GB}
        "32GB"{[Int64]$script:VHDgbSize=32GB}
        "48GB"{[Int64]$script:VHDgbSize=48GB}
        "64GB"{[Int64]$script:VHDgbSize=64GB}
        "80GB"{[Int64]$script:VHDgbSize=80GB}
        "120GB"{[Int64]$script:VHDgbSize=120GB}
    }

	if(Test-Path $VHDSPath){$null}else{[void](New-Item -Path $VHDSPath -ItemType Directory -Force)}
	if(Test-Path $vmsPath){$null}else{[void](New-Item -Path $vmsPath -ItemType Directory -Force)}
}

<# - - - - # - - - - # - - - - # - - - - #
End of the New_blank_VM_Template block  
 - - - - # - - - - # - - - - # - - - - #>

function New_blank_VM-GNU_Linux{
Clear-Host
Write-Host "1 - pfSense`n"

Write-Host "2 - Debian"
Write-Host "3 - CentOS"
Write-Host "4 - Rocky Linux"
Write-Host "5 - Ubuntu`n"

Write-Host "6 - Parrot Security"
Write-Host "7 - Kali Linux`n"

Write-Host "8 - Tails`n"
Write-Host "0 - Back to the main menu`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{New_blank_VM-GNU_Linux_pfSense}

    	2{New_blank_VM-GNU_Linux_Debian}
    	3{New_blank_VM-GNU_Linux_CentOS}
    	4{New_blank_VM-GNU_Linux_Rocky_Linux}
    	5{New_blank_VM-GNU_Linux_Ubuntu}

    	6{New_blank_VM-GNU_Linux_Parrot_Security}
    	7{New_blank_VM-GNU_Linux_Kali_Linux}
    	
    	8{New_blank_VM-GNU_Linux_Tails}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function New_blank_VM-Microsoft_Windows{
Clear-Host
Write-Host "1 - Microsoft Windows 11 multiple editions`n"

Write-Host "2 - Microsoft Windows 10 Entreprise LTSC"
Write-Host "3 - Microsoft Windows 10 multiple editions`n"

Write-Host "4 - Microsoft Windows Server 2012"
Write-Host "5 - Microsoft Windows Server 2016"
Write-Host "6 - Microsoft Windows Server 2019"
Write-Host "7 - Microsoft Windows Server 2022`n"
Write-Host "0 - Back to the main menu`n" -ForegroundColor darkred

[int]$userchoice=Read-Host "Your choice"
	switch($userchoice)
	{
    	1{New_blank_VM-Microsoft_Windows_11_multiple_editions}

    	2{New_blank_VM-Microsoft_Windows_10_Entreprise_LTSC}
    	3{New_blank_VM-Microsoft_Windows_10_Multiple_Editions}

    	4{New_blank_VM-Microsoft_Windows_10_Server_2012}
    	5{New_blank_VM-Microsoft_Windows_10_Server_2016}
    	6{New_blank_VM-Microsoft_Windows_10_Server_2019}
    	7{New_blank_VM-Microsoft_Windows_10_Server_2022}

    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function New_blank_VM{
Clear-Host
Write-Host "What type of operating system corresponds to the machine you want to generate?`n"
Write-Host "1 - Microsoft Windows"
Write-Host "2 - GNU/Linux`n"
Write-Host "0 - Back to the main menu`n" -ForegroundColor darkred

[int]$user_choice=Read-Host "Your choice"
	switch($user_choice)
	{
    	1{New_blank_VM-Microsoft_Windows}
    	2{New_blank_VM-GNU_Linux}
    
    	0{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

function main{
$host.ui.RawUI.WindowTitle="Hyper-V Toolbox - Franck FERMAN"
Clear-Host

Write-Host "";Write-Host -ForegroundColor darkyellow	"                               _oo0oo_                  ";Write-Host -ForegroundColor darkyellow	"                              o8888888o                 ";Write-Host -ForegroundColor darkyellow	"                              88`" . `"88               ";Write-Host -ForegroundColor darkyellow	"                              (| -_- |)                 ";Write-Host -ForegroundColor darkyellow	"                              0\  =  /0                 ";Write-Host -ForegroundColor darkyellow	"                            ___/`----'\___              ";Write-Host -ForegroundColor darkyellow	"                          .' \\|     |// '.             ";Write-Host -ForegroundColor darkyellow	"                         / \\|||  :  |||// \            ";Write-Host -ForegroundColor darkyellow	"                        / _||||| -:- |||||- \           ";Write-Host -ForegroundColor darkyellow	"                       |   | \\\  -  /// |   |          ";Write-Host -ForegroundColor darkyellow	"                       | \_|  ''\---/''  |_/ |          ";Write-Host -ForegroundColor darkyellow	"                       \  .-\__  '-'  ___/-. /          ";Write-Host -ForegroundColor darkyellow	"                     ___'. .'  /--.--\  `. .'___        ";Write-Host -ForegroundColor darkyellow	"                  .`"`" '<  `.___\_<|>_/___.' >' `"`".  ";Write-Host -ForegroundColor darkyellow	"                 | | :  `- \`.;`\ _ /`;.`/ - ` : | |    ";Write-Host -ForegroundColor darkyellow	"                 \  \ `_.   \_ __\ /__ _/   .-` /  /    ";Write-Host -ForegroundColor darkyellow	"             =====`-.____`.___ \_____/___.-`___.-'===== ";Write-Host -ForegroundColor darkyellow  "                               `=---='                  ";Write-Host -ForegroundColor darkyellow "  _  _                      __   __  _____         _ _             	";Write-Host -ForegroundColor darkyellow " | || |_  _ _ __  ___ _ _ __\ \ / / |_   _|__  ___| | |__  _____ __ ";Write-Host -ForegroundColor darkyellow " | __ | || | '_ \/ -_) '_|___\ V /    | |/ _ \/ _ \ | '_ \/ _ \ \ /	";Write-Host -ForegroundColor darkyellow " |_||_|\_, | .__/\___|_|      \_/     |_|\___/\___/_|_.__/\___/_\_\	";Write-Host -ForegroundColor darkyellow "       |__/|_|                                                     	";Write-Host "`n	Hello " -NoNewline;Write-Host "$env:UserName "-NoNewline -ForegroundColor green;Write-Host "and welcome to "-NoNewLine;Write-Host "Hyper-V Toolbox"-NoNewLine -ForegroundColor green;Write-Host ".";Write-Host ""

Write-Host "1 - Creation of blank virtual machines"
Write-Host "2 - Creation of preconfigured virtual machines"
Write-Host ""
Write-Host "3 - Management of virtual machines"
Write-Host "4 - Management of virtual switches"
Write-Host ""
Write-Host "5 - Management of local resources"
Write-Host ""
Write-Host "0 - Quit the program" -ForegroundColor darkred
Write-Host ""

[int]$user_choice=Read-Host "Your choice"
	switch($user_choice)
	{
    	1{New_blank_VM}
    	2{New_preconfigured_VM}
    	3{VM_management}
    	4{VirtualSwitch_management}
    	5{LocalRessources_management}

    	0{$host.ui.RawUI.WindowTitle=$Default_WindowTitle;Write-Host "";Write-Host "Good luck with your work"-NoNewLine -ForegroundColor green;Write-Host ".`n";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused"-NoNewLine -ForegroundColor red;Write-Host ".";Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu"-NoNewLine -ForegroundColor red;Write-Host ".`n";pause;main}
	}
}

Check_Administrator_Rights