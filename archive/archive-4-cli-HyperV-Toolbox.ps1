#requires -version 2

<#
.SYNOPSIS
  Hyper-V Toolbox is a PowerShell script allowing advanced manipulation of Hyper-V from your terminal.

.DESCRIPTION
  Hyper-V Toolbox is a PowerShell script for managing virtual machines with Hyper-V, inspired by Vagrant and Docker.

.PARAMETER command
  -command help : display the help message
  -command test : testing function

.NOTES
  Author  : Franck FERMAN (contact@franckferman.fr)
  Version : 3.0
  Update Date : 11/23/2022

.EXAMPLE
  Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force;.\hyper-v_toolbox.ps1
#>

<#==========
head
==========#>

<#=====
cli args parsing
=====#>
[CmdletBinding()]
  Param(
    [Parameter(Mandatory=$false)]
    [string]$name="vm"+(Get-Random -Minimum 0 -Maximum 9999),
    [string]$command=0,
    [string]$mkvm=0,
    [string]$isoLocalPath=".\src\iso\$name",
    [string]$IsoPathDirectory=".\src\iso\",
    [string]$IsoSource="https://depository.fra1.digitaloceanspaces.com/",
    [string]$VHDPath=".\conf\vhds",
    [string]$vmsPath=".\conf\vms",
    [string]$UseNetwork="Disabled",
    [Int64]$Memory=2GB,
    [string]$OS="0"
)

Set-StrictMode -Version Latest

<#=====
OS
=====#>

<#=====
OS blank
=====#>
$Microsoft_Windows_OS_blank_List=@()
$GNU_Linux_OS_blank_List=@()
$All_OS_blank_List=@()

$Microsoft_Windows_OS_blank_List=@(
    'Windows Server 2022'
    'Windows 10 Entreprise LTSC'
)

$GNU_Linux_OS_blank_List=@(
    'Debian'
    'Parrot Security'
)

$All_OS_blank_List=$Microsoft_Windows_OS_blank_List+$GNU_Linux_OS_blank_List

<#=====
OS templates
=====#>
$Microsoft_Windows_OS_template_List=@()
$GNU_Linux_OS_template_List=@()
$All_OS_template_List=@()

$Microsoft_Windows_OS_template_List=@(
    'Windows Server 2022'
    'Windows 10 Entreprise LTSC'
)

$GNU_Linux_OS_template_List=@(
    'Debian'
    'Parrot Security'
)

$All_OS_template_List=$Microsoft_Windows_OS_template_List+$GNU_Linux_OS_template_List

<#==========
body
==========#>

<#=====
Administrator rights checking function
=====#>
function Check_Administrator_Rights
{
[CmdletBinding()]
  Param(
    [bool]$is_it_Administrator=(New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
)
  PROCESS{
    switch($is_it_Administrator){
      $true{main}
      $false{Write-Host "Please run the script with administrator rights." -ForegroundColor Red;exit}
      default{Write-Host "An unexpected error was caused." -ForegroundColor Red;exit}
    }
  }
}

<#=====
Function to guide the user if no value is defined
=====#>
function Show_Help
{
Write-Host "No parameter has been identified.`r`n" -ForegroundColor red
Write-Host "List of commands :`r`n"
Write-Host "General :"
Write-Host "-command help : displays this help message."
Write-Host "-command test : testing function.`r`n"

Write-Host "Creating a new virtual machine (mkvm) :"
Write-Host "-mkvm help : displays the mkvm help message."
Write-Host "-mkvm test : testing function."
Write-Host "-mkvm list : displays the complete list of virtual machines that can be generated."
}

<#=====
Alternative to lorem ipsum, for testing purposes
=====#>
function Lorem_Testing
{
$words=@('Franck','Morty','Rick','Jerry', 'test', 'log',
    'Beth','Squanchy','2600','Axel','Lionel','Pig',
    'Marie','Myriam','Chamallow','Marshmello','Rabbit','Armenia',
    'Lorem', 'Ipsum', 'Jacob', 'Israel', 'Naruto', 'Jiraya', 'Sasuke'
)

$word1=Get-Random -InputObject $words
$word2=Get-Random -InputObject $words
$word3=Get-Random -InputObject $words
$word4=Get-Random -InputObject $words

$lorem = "$word1 $word2 $word3 $word4"

$colors=@('White','Green','Red','Blue',
    'Yellow','Black','Cyan','Magenta','Gray'
)

$color=Get-Random -InputObject $colors

LogToConsole -Message $lorem -color $color
}

<#=====
Function to create a new blank virtual machine
=====#>
function mkvm_blank
{
[CmdletBinding()]
  Param(
    [Parameter(Mandatory=$false)]
    [string]$name=$name,
    [string]$OS=$OS,
    [string]$isoLocalPath=$isoLocalPath,
    [string]$IsoPathDirectory=$IsoPathDirectory,
    [string]$IsoSource=$IsoSource,
    [string]$VHDPath=$VHDPath,
    [string]$vmsPath=$vmsPath
)

if($OS -eq "0"){Write-Host '[!] The parameter "-OS" has not been specified.' -ForegroundColor red;Write-Host 'To display the list of available OS, you can use the command : "-mkvm list", or "-mkvm list_blank" for blank machines specifically.';exit}
elseif($OS -notin $All_OS_blank_List){Write-Host '[!] There is no OS available for your request.' -ForegroundColor red;Write-Host 'To display the list of available OS, you can use the command : "-mkvm list", or "-mkvm list_blank" for blank machines specifically.';exit}
elseif($OS -in $All_OS_blank_List){Write-Host "OS chosen for the virtual machine : $OS`n`r" -ForegroundColor green}
else{Write-Host "An unexpected error was caused." -ForegroundColor Red;exit}

if($Name.StartsWith("vm")){Write-Host '[!] The parameter "-name" has not been specified.' -ForegroundColor Yellow -NoNewLine;Ask_YesOrNo "Would you like to continue ?" "If no argument is specified, a partially altered name will be generated..."}
  switch($Ask_YesOrNo_Result)
    {
      1{[bool]$Use_Microsoft_Windows=$false}  
      0{[bool]$Use_Microsoft_Windows=$true    ## Begin if Microsoft Windows is True
      }
    }

elseif($Name -match "[A-Z]|[0-9]"){Write-Host "Name chosen for the virtual machine : $name`n`r" -ForegroundColor green}
else{Write-Host "An unexpected error was caused." -ForegroundColor Red;exit}
}

<#=====
Function to create a new template virtual machine
=====#>
function mkvm_template
{
[CmdletBinding()]
  Param(
    [Parameter(Mandatory=$false)]
    [string]$command=0,
    [string]$mkvm=0
  )
}


<#=====
mkvm_full_list
=====#>
function mkvm_full_list
{
$Formatted_List=$All_OS_blank_List -join "`n`r"
Write-Host "Blank`nvirtual machines"
LogToConsole "$Formatted_List" "DarkGreen"
$Formatted_List=$All_OS_template_List -join "`n`r"
Write-Host "Virtual machine`ntemplates"
LogToConsole "$Formatted_List" "Green"
}

<#=====
mkvm_list_blank
=====#>
function mkvm_list_blank
{
$Formatted_List=$All_OS_blank_List -join "`n`r"
LogToConsole "Blank virtual machines :`n`r$Formatted_List" "DarkGreen"
}

<#=====
mkvm_list_template
=====#>
function mkvm_list_template
{
$Formatted_List=$All_OS_blank_List -join "`n`r"
LogToConsole "Blank virtual machines :`n`r$Formatted_List" "DarkGreen"
}

<#=====
main
=====#>
function main
{
[string]$script:Default_WindowTitle=$host.ui.RawUI.WindowTitle
$host.ui.RawUI.WindowTitle="Hyper-V Toolbox - Franck FERMAN"
Clear-Host

  if($command -ne 0){
    switch($command){
      help{Show_Help}
      test{Lorem_Testing}
      commands{Show_Commands}
      default{Write-Host "An unexpected error was caused." -ForegroundColor Red;exit}
    }

  }elseif($command -eq 0 -and $mkvm -ne 0){
    switch($mkvm){
      help{Show_mkvm_Help}
      test{Lorem_Testing}
      commands{Show_mkvm_Commands}
      blank{mkvm_blank}
      template{mkvm_template}
      list{mkvm_full_list}
      list_blank{mkvm_list_blank}
      list_template{mkvm_list_template}
    }
  }

elseif($command -eq 0){Show_Help}

$host.ui.RawUI.WindowTitle=$Default_WindowTitle
}

function Ask_YesOrNo
{
[CmdletBinding()]
  Param(
    [string]$title,
    [string]$message
  )

$choiceYes=New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","Yes"
$choiceNo=New-Object System.Management.Automation.Host.ChoiceDescription "&No","No"
$options=[System.Management.Automation.Host.ChoiceDescription[]]($choiceYes,$choiceNo)
[int]$script:Ask_YesOrNo_Result=$host.ui.PromptForChoice($title,$message,$options,1)
}

Function LogToConsole([string]$message="console.log",[string]$color="Green")
{
    Write-Host "====="
    Write-Host "$message " -ForegroundColor $color
    Write-Host "=====`r`n"
}

Check_Administrator_Rights