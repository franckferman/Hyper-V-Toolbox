<#
.SYNOPSIS
Hyper-V Toolbox is an interactive PowerShell script inspired by Docker and Vagrant, designed for efficient virtual machine management.

.DESCRIPTION
This project is dedicated to providing users with an efficient and user-friendly tool for virtual machine management. With a focus on streamlining the virtual machine management process, this tool offers a range of features designed to enhance productivity and simplify operations.

.PARAMETER
-help: Displays the help menu for Hyper-V Toolbox.

.INPUTS
None. Interactive inputs via prompts.

.OUTPUTS
Text-based outputs to the console detailing the VM management process.

.REQUIREMENTS
PowerShell 5.0 or later.
Hyper-V Module.

.LICENSE
GNU Affero General Public License v3.0. Please see the [LICENSE] file on the GitHub repository (https://github.com/franckferman/Hyper-V_Toolbox/blob/main/LICENSE) for the full license details.

.CREDITS
Inspired by Docker (https://www.docker.com/) and Vagrant (https://www.vagrantup.com/).

.EXAMPLE
PS > Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process; .\hyper-v_toolbox.ps1

.NOTES
Author: Franck Ferman
Version: 1.0.0

.LINK
https://github.com/franckferman/Hyper-V_Toolbox
#>

param (
    [Switch]$help
)

[String]$Script:scriptVersion = "1.0.0"

# Declaration of Global variables containing download links to JSON files allowing access to downloadable resources (images and virtual hard drives).

# Recover files containing links to resources from GitHub.
[System.Uri]$Script:Blank_Windows_JSON_LinksFile = 'https://raw.githubusercontent.com/franckferman/Hyper-V_Toolbox/main/assets/links/blank_windows.json'
[System.Uri]$Script:Blank_Linux_JSON_LinksFile = 'https://raw.githubusercontent.com/franckferman/Hyper-V_Toolbox/main/assets/links/blank_linux.json'
# [System.Uri]$Script:Preconfigured_Windows_JSON_Links_File = 'https://raw.githubusercontent.com/franckferman/Hyper-V_Toolbox/main/assets/links/preconfigured_windows.json'
# [System.Uri]$Script:Preconfigured_Linux_JSON_Links_File = 'https://raw.githubusercontent.com/franckferman/Hyper-V_Toolbox/main/assets/links/preconfigured_linux.json'

# Recover files containing links to resources from Google Drive.
# [System.Uri]$Script:Blank_Windows_JSON_LinksFile = 'https://drive.google.com/file/d/id/view?usp=sharing'
# [System.Uri]$Script:Blank_Linux_JSON_LinksFile = 'https://drive.google.com/file/d/id/view?usp=sharing'
# [System.Uri]$Script:Preconfigured_Windows_JSON_Links_File = 'https://drive.google.com/file/d/id/view?usp=sharing'
# [System.Uri]$Script:Preconfigured_Linux_JSON_Links_File = 'https://drive.google.com/file/d/id/view?usp=sharing'

# Recover files containing links to resources from Proton Drive.
# Examples to be defined.

# Recover files containing links to resources from a local resource or network share.
# [String]$Script:Blank_Windows_JSON_LinksFile = '\\COMPUTER\SHARE'
# [String]$Script:Blank_Linux_JSON_LinksFile = '\\COMPUTER\SHARE'
# [System.Uri]$Script:Preconfigured_Windows_JSON_Links_File = ''\\COMPUTER\SHARE'
# [System.Uri]$Script:Preconfigured_Linux_JSON_Links_File = ''\\COMPUTER\SHARE'

# Declaration of banner groups.
[Array]$Script:Window_Banners = @("Window_PS_Terminal", "Window_PS_Terminal_Old_Computer", "Teddy_Screen")
[Array]$Script:Windows_Banners = @("Windows_logo", "Windows_on_laptop")
[Array]$Script:Linux_Banners = @("Linux_Penguin", "Linux_Devil", "Talking_Linux_Penguin", "Cowsay")
[Array]$Script:Space_Banners = @("Rocket_launch", "Space_odyssey", "Galaxy")
[Array]$Script:Misc_Banners = @("Monkey", "HPV-TBX_text")


function Display-Help {
    <#
    .SYNOPSIS
    Displays the help menu for Hyper-V Toolbox.

    .DESCRIPTION
    This function generates and presents the help menu for Hyper-V Toolbox, outlining how to use the script and its potential options.
    #>

    Write-Host "Hyper-V Toolbox Help Menu"
    Write-Host "--------------------------"
    Write-Host "To run Hyper-V Toolbox in interactive mode, simply execute:"
    Write-Host "PS > .\hyper-v_toolbox.ps1"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "-h, --help      Display this help menu."
    Write-Host ""
    Write-Host "Once inside the interactive mode, follow on-screen prompts to manage your virtual machines."
}


function Test-AdminRights {
    [CmdletBinding()]
    [OutputType([Bool])]
    param()

    <#
    .SYNOPSIS
    Tests if the current user has administrator rights.

    .DESCRIPTION
    This function will determine if the current user is part of the Administrator role. It utilizes the .NET classes for Windows Security and Principal Windows Built-in Roles to make this determination.

    .EXAMPLE
    if (Test-AdminRights) {
        Write-Host "You are running as an administrator."
    } else {
        Write-Host "You are not running as an administrator."
    }
    #>

    $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($identity)
    $adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator

    return $principal.IsInRole($adminRole)
}


function Test-Prerequisites {
    <#
    .SYNOPSIS
    Checks if the necessary prerequisites are met.

    .DESCRIPTION
    This function verifies if the Hyper-V feature is enabled and if the PowerShell version is at least 5.

    .EXAMPLE
    if (Test-Prerequisites) {
        Write-Host "All prerequisites are met."
    } else {
        Write-Host "Some prerequisites are missing."
    }
    #>

    $hyperVEnabled = Get-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V-All -Online | 
                     Where-Object {$_.State -eq 'Enabled'}

    if (-not $hyperVEnabled) {
        Write-Warning "Hyper-V feature is not enabled."
        return $false
    }

    Import-Module Hyper-V

    $psVersion = $PSVersionTable.PSVersion.Major
    if ($psVersion -lt 5) {
        Write-Warning "PowerShell version is below 5. Current version: $psVersion"
        return $false
    }

    return $True
}


function Get-WANStatus {
    <#
    .SYNOPSIS
    Tests the WAN connection by trying to reach one of the provided URLs.

    .DESCRIPTION
    This function randomly selects one of the provided URLs (or default URLs if none are provided) and attempts to reach it.
    If successful, it returns "Online". Otherwise, it returns "Offline" or provides an error message.

    .PARAMETER urls
    An array of URLs to be tested. If none are provided, default URLs are used.

    .EXAMPLE
    Get-WANStatus -urls 'https://httpbin.org/get'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [System.Uri[]]$urls = @('https://httpbin.org/get', 'https://httpstat.us/200')
    )

    [String]$selectedUrl = Get-Random -InputObject $urls -Count 1
    $webSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

    try {
        $ProgressPreference = 'SilentlyContinue'
        $response = Invoke-WebRequest -Uri $selectedUrl -WebSession $webSession -Headers @{
            'User-Agent' = 'Hyper-V_Toolbox/1.0.0'
        } -UseBasicParsing -TimeoutSec 5

        if ([Byte]$response.StatusCode -eq 200) {
            return "Online"
        } else {
            return "Offline - Received status code $($response.StatusCode)"
        }

    } catch {
        return "Offline - Error: $($_.Exception.Message)"
    }

}


function Get-Update {
    <#
    .SYNOPSIS
    Checks if there's an update available for the script from the provided repository.

    .DESCRIPTION
    This function fetches the content of the script from the specified repository URL, extracts the version, and compares it with the current script's version.

    .PARAMETER repositoryUrl
    The URL to the raw content of the script in the repository. Default is the provided GitHub repository.

    .EXAMPLE
    if (Get-Update) {
        Write-Host "An update is available."
    } else {
        Write-Host "You have the latest version."
    }
    #>

    [CmdletBinding()]
    [OutputType([Bool])]
    param (
        [Parameter(Mandatory=$false)]
        [System.Uri]$repositoryUrl = 'https://raw.githubusercontent.com/franckferman/Hyper-V_Toolbox/main/hyper-v_toolbox.ps1'
    )

    try {
        $ProgressPreference = 'SilentlyContinue'
        $Content = (Invoke-WebRequest -Uri $repositoryUrl -UseBasicParsing -TimeoutSec 5).Content

        $VersionMatch = [regex]::Match($Content, 'Version:\s*(\d+\.\d+\.\d+)')
        
        if (-not $VersionMatch.Success) {
            throw "Failed to extract the script version from the repository."
        }

        [System.Version]$CurrentVersion = New-Object System.Version $scriptVersion
        [System.Version]$RepositoryVersion = New-Object System.Version $VersionMatch.Groups[1].Value

        return $CurrentVersion -lt $RepositoryVersion

    } catch [System.Net.WebException] {
        Write-Warning "Failed to connect to the repository. Check your internet connection and try again."
    } catch {
        Write-Warning "An unexpected error occurred during the script update check: $($_.Exception.Message)"
    }

    return $false
}


function PauseForUser {
    <#
    .SYNOPSIS
    Pauses script execution until the user presses Enter.

    .DESCRIPTION
    Displays a message prompting the user to press Enter to continue.
    #>
    Read-Host 'Press enter to continue...'
}


function Select-main_Menu {
    <#
    .SYNOPSIS
    Main menu loop for user interaction.

    .DESCRIPTION
    This function loops continuously, displaying the main menu and processing user input.
    #>

    while ($True) {
        Show-main_Menu
        Write-Host ''

        $choice = Read-Host 'Enter your choice'
        Switch ($choice) {
            '1' { Select-BlankVM-Menu }
            '2' { Show-UnderDevelopmentMessage }
            '3' { Show-UnderDevelopmentMessage }
            '4' { Show-UnderDevelopmentMessage }
            '5' { Show-UnderDevelopmentMessage }
            '6' { LocalResourceManagement-Menu }
            'h' { Write-Host (Display_interactive_help) ; Write-Host '' ; PauseForUser }
            'q' { Write-Host '' ; ScriptExit -ExitCode 0 }
            default { Show-InvalidInput }
        }
    }
}


function Show-Banner {
    <#
    .SYNOPSIS
    Displays an artistic banner in the console.

    .DESCRIPTION
    The Show-Banner function allows you to display different types of artistic banners in the console.

    .PARAMETER BannerType
    Specifies the type of banner to display.
    If not specified, a random banner will be shown, except Buddha, which is used for the main menu only.

    .EXAMPLE
    Show-Banner -BannerType "Buddha"
    This command displays the "Buddha" banner.
    #>

    param (
        [Parameter(Mandatory = $false)]
        [ValidateSet("Buddha", "Window_PS_Terminal", "Window_PS_Terminal_Old_Computer", "Teddy_Screen", "Monkey", "Linux_Penguin", "Linux_Devil", "Talking_Linux_Penguin", "Cowsay", "Windows_logo", "Windows_on_laptop", "Rocket_launch", "Space_odyssey", "Galaxy", "HPV-TBX_text", "Window_Banners", "Windows_Banners", "Linux_Banners", "Space_Banners", "Misc_Banners")]
        [String]$BannerType = (Get-Random -InputObject @("Window_PS_Terminal", "Window_PS_Terminal_Old_Computer", "Teddy_Screen", "Monkey", "Linux_Penguin", "Linux_Devil", "Talking_Linux_Penguin", "Cowsay", "Windows_logo", "Windows_on_laptop", "Rocket_launch", "Space_odyssey", "Galaxy", "HPV-TBX_text"))
    )

    Switch ($BannerType) {
        "Window_Banners" { $BannerType = Get-Random -InputObject $Window_Banners ; Show-Banner $BannerType }
        "Windows_Banners" { $BannerType = Get-Random -InputObject $Windows_Banners ; Show-Banner $Windows_Banners }
        "Linux_Banners" { $BannerType = Get-Random -InputObject $Linux_Banners ; Show-Banner $Linux_Banners }
        "Space_Banners" { $BannerType = Get-Random -InputObject $Space_Banners ; Show-Banner $Space_Banners }
        "Misc_Banners" { $BannerType = Get-Random -InputObject $Misc_Banners ; Show-Banner $Misc_Banners }

        "Buddha" {
           @"
                                  _
                               _ooOoo_
                              o8888888o
                              88" . "88
                              (| -_- |)
                              O\  =  /O
                           ____/'---'\____
                         .'  \\|     |//  '.
                        /  \\|||  :  |||//  \
                       /  _||||| -:- |||||_  \
                       |   | \\\  -  /'| |   |
                       | \_|  '\'---'//  |_/ |
                       \  .-\__ '-. -'__/-.  /
                     ___'. .'  /--.--\  '. .'___
                  ."" '<  '.___\_<|>_/___.' _> \"".
                 | | :  '- \'. ;'. _/; .'/ /  .' ; |
                 \  \ '-.   \_\_'. _.'_/_/  -' _.' /
       ==========='-.'___'-.__\ \___  /__.-'_.'_.-'================
                               '=--=-'
                                          _____            _ _               
  /\  /\_   _ _ __   ___ _ __    /\   /\ /__   \___   ___ | | |__   _____  __
 / /_/ / | | | '_ \ / _ \ '__|___\ \ / /   / /\/ _ \ / _ \| | '_ \ / _ \ \/ /
/ __  /| |_| | |_) |  __/ | |_____\ V /   / / | (_) | (_) | | |_) | (_) >  < 
\/ /_/  \__, | .__/ \___|_|        \_/    \/   \___/ \___/|_|_.__/ \___/_/\_\
        |___/|_|                                                                       
"@
        }
        "Window_PS_Terminal" {
            @"
 _______________________________________________________________________
|[>] Hyper-V Toolbox                                         [-]|[]|[x]"|
|"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"|
|PS C:\WINDOWS\system32> Set-Location -Path C:\Users\$env:USERNAME          | |
|PS C:\Users\$env:USERNAME> .\hyper-v_toolbox.ps1                           | |
|                                                                     |_|
|_____________________________________________________________________|/|
"@
        }
        "Window_PS_Terminal_Old_Computer" {
            @"
  .---------.
  |.-------.|
  ||PS C:\>||
  ||       ||
  |"-------'|
.-^---------^-.
| ---~[HPV    |
| Toolbox]---~|
"-------------'
"@
        }
        "Teddy_Screen" {
            @"
                     ,---.           ,---.
                    / /"'.\.--"""--./,'"\ \
                    \ \    _       _    / /
                     './  / __   __ \  \,'
                      /    /_O)_(_O\    \
                      |  .-'  ___  '-.  |
                   .--|       \_/       |--.
                 ,'    \   \   |   /   /    '.
                /       '.  '--^--'  ,'       \
             .-"""""-.    '--.___.--'     .-"""""-.
.-----------/         \------------------/         \--------------.
| .---------\         /----------------- \         /------------. |
| |          '-'--'--'                    '--'--'-'             | |
| |                                                             | |
| |           __7__          %%%,%%%%%%%                        | |
| |           \_._/           ,'%% \\-*%%%%%%%                  | |
| |           ( ^ )     ;%%%%%*%   _%%%%                        | |
| |            '='|\.    ,%%%       \(_.*%%%%.                  | |
| |              /  |    % *%%, ,%%%%*(    '                    | |
| |            (/   |  %^     ,*%%% )\|,%%*%,_                  | |
| |            |__, |       *%    \/ #).-*%%*                   | |
| |             |   |           _.) ,/ *%,                      | |
| |             |   |   _________/)#(_____________              | |
| |             /___|  |__________________________|             | |
| |             ===         [Hyper-V Toolbox]                   | |
| |_____________________________________________________________| |
|_________________________________________________________________|
                   )__________|__|__________(
                  |            ||            |
                  |____________||____________|
                    ),-----.(      ),-----.(
                  ,'   ==.   \    /  .==    '.
                 /            )  (            \
                 '==========='    '===========' 
"@
        }
        "Monkey" {
            @"
                        .="=.
                      _/.-.-.\_     _
                     ( ( o o ) )    ))
      .-------.       |/  "  \|    //
      |  HPV  |        \'---'/    //
     _|  TBX  |_       /'"""'\\  ((
   =(_|_______|_)=    / /_,_\ \\  \\
     |:::::::::|      \_\\_'__/ \  ))
     |:::::::[]|       /'  /'~\  |//
     |o=======.|      /   /    \  /
     '"""""""""'  ,--',--'\/\    /
                   '-- "--'  '--'
"@
        }
        "Linux_Penguin" {
            @"
       .---.
      /     \
      \.@-@./
      /'\_/'\
     //  _  \\
    | \     )|_
   /'\_'>  <_/ \
   \__/'---'\__/
"@
        }
        "Linux_Devil" {
            @"
             ,        ,
            /(        )'
            \ \___   / |
            /- _  '-/  '
           (/\/ \ \   /\
           / /   | '    \
           O O   ) /    |
           '-^--''<     '
          (_.)  _  )   /
           '.___/'    /
             '-----' /
<----.     __ / __   \
<----|====O)))==) \) /====
<----'    '--' '.__,' \
             |        |
              \       /
         ______( (_  / \______
       ,'  ,-----'   |        \
       '--{__________)        \/
"@
        }
        "Talking_Linux_Penguin" {
            @"
         _nnnn_                      
        dGGGGMMb     ,""""""""""""""""".
       @p~qp~~qMb    | Hyper-V Toolbox |
       M|@||@) M|   _;.................'
       @,----.JM| -'
      JS^\__/  qKL
     dZP        qKRb
    dZP          qKKb
   fZP            SMMb
   HZM            MMMM
   FqM            MMMM
 __| ".        |\dS"qML
 |    '.       | '' \Zq
_)      \.___.,|     .'
\____   )MMMMMM|   .'
     '-'       '--'
"@
        }
        "Cowsay" {
            @"
 __________________
( Hyper-V Toolbox  )
 ------------------
        o   ^__^
         o  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
"@
        }
        "Windows_logo" {
            @"
 .----------------.
|          _       |
|      _.-'|'-._   |
| .__.|    |    |  |
|     |_.-'|'-._|  |
| '--'|    |    |  |
| '--'|_.-'-'-._|  |
| '--'             |
 '----------------'
"@
        }
        "Windows_on_laptop" {
            @"
   ._________________.
   |.---------------.|
   ||   -._ .-.     ||
   ||   -._| | |    ||
   ||   -._|"|"|    ||
   ||   -._|.-.|    ||
   ||_______________||
   /.-.-.-.-.-.-.-.-.\
  /.-.-.-.-.-.-.-.-.-.\
 /.-.-.-.-.-.-.-.-.-.-.\
/______/__________\___o_\
\_______________________/
"@
        }
        "Rocket_launch" {
            @"
         *                 *                  *              *
                                                      *             *
                        *            *                             ___
  *               *                                          |     | |
        *              _________##                 *        / \    | |
                      @\\\\\\\\\##    *     |              |--o|===|-|
  *                  @@@\\\\\\\\##\       \|/|/            |---|   | |
                    @@ @@\\\\\\\\\\\    \|\\|//|/     *   /     \  | |
             *     @@@@@@@\\\\\\\\\\\    \|\|/|/         | H-T   | | |
                  @@@@@@@@@----------|    \\|//          | P-B   |=| |
       __         @@ @@@ @@__________|     \|/           | V-X   | | |
  ____|_@|_       @@@@@@@@@__________|     \|/           |_______| |_|
=|__ _____ |=     @@@@ .@@@__________|      |             |@| |@|  | |
____0_____0__\|/__@@@@__@@@__________|_\|/__|___\|/__\|/___________|_|_
"@
        }
        "Space_odyssey" {
            @"
                                             _.--"""""--._
                                          ,-'             '-.
               _                        ,' --- -  ----   --- '.
             ,'|'.                    ,'       ________________'.
            O'.+,'O                  /        /____(_______)___\ \
   _......_   ,=.         __________;   _____  ____ _____  _____  :
 ,'   ,--.-',,;,:,;;;;;;;///////////|   -----  ---- -----  -----  |
(    (  ==)=========================|      ,---.    ,---.    ,.   |
 '._  '--'-,''''''"""""""\\\\\\\\\\\:     /'. ,'\  /_    \  /\/\  ;
    ''''''                           \    :  Y  :  :-'-. :  : ): /
                                      '.  \  |  /  \=====/  \/\/'
                                        '. '-'-'    '---'    ;'
                                          '-._           _,-'
                                              '--.....--'   ,--.
                                                           ().0()
                                                            ''-'
"@
        }
        "Galaxy" {
            @"
   .        .        .        .        .        .        .        .        .
     .         .         .        _......____._        .         .
   .          .          . ..--'"" .           """"""---...          .
                   _...--""        ................       '-.              .
                .-'        ...:'::::;:::%:.::::::_;;:...     '-.
             .-'       ..::::'''''   _...---'"""":::+;_::.      '.      .
  .        .' .    ..::::'      _.-""               :::)::.       '.
         .      ..;:::'     _.-'         .             f::'::    o  _
        /     .:::%'  .  .-"                        .-.  ::;;:.   /" "x
  .   .'  ""::.::'    .-"     _.--'"""-.           (   )  ::.::  |_.-' |
     .'    ::;:'    .'     .-" .d@@b.   \    .    . '-'   ::%::   \_ _/    .
    .'    :,::'    /   . _'    8@@@@8   j      .-'       :::::      " o
    | .  :.%:' .  j     (_)    '@@@P'  .'   .-"         ::.::    .  f
    |    ::::     (        -..____...-'  .-"          .::::'       /
.   |    ':'::    '.                ..--'        .  .::'::   .    /
    j     ':::::    '-._____...---""             .::%:::'       .'  .
     \      ::.:%..             .       .    ...:,::::'       .'
 .    \       ':::':..                ....::::.::::'       .-'          .
       \    .   '':::%::'::.......:::::%::.::::''       .-'
      . '.        . ''::::::%::::.::;;:::::'''      _.-'          .
  .       '-..     .    .   '''''''''         . _.-'     .          .
         .    ""--...____    .   ______......--' .         .         .
  .        .        .    """"""""     .        .        .        .        .
"@
        }
        "HPV-TBX_text" {
            @"
 _     ___   _         _____  ___   _ 
| |_| | |_) \ \  /      | |  | |_) \ \_/
|_| | |_|    \_\/       |_|  |_|_) /_/ \
"@
        }
    }
}


function Display_interactive_help {
    <#
    .SYNOPSIS
    Displays the interactive help menu for the Hyper-V Toolbox.
    
    .DESCRIPTION
    The function presents an ASCII-styled help menu for the Hyper-V Toolbox, providing a brief description and visual representation of the tool.
    #>

[console]::Clear()
    @"
                                             _______________________
   _______________________-------------------                       '\
 /:--__                                                              |
||< > |                                   ___________________________/
| \__/_________________-------------------                         |
|                                                                  |
 |                       HYPER-V Toolbox                           |
 |                    Interactive Help Menu                         |
 |                                                                  |
  |        "Hyper-V Toolbox is an interactive PowerShell script      |
  |        designed for efficient virtual machine management."       |
   |                                                                  |
  |                                              ____________________|_
  |  ___________________-------------------------                      '\
  |/'--_                                                                 |
  ||[ ]||                                            ___________________/
   \===/___________________--------------------------
"@
}


function ScriptExit {
    <#
    .SYNOPSIS
    Terminates the script execution with a given exit code.

    .DESCRIPTION
    This function provides a unified exit point for the script, logging the exit reason, and using the provided exit code.
    An exit code of 0 usually indicates success, while any other number indicates an error.

    .PARAMETER ExitCode
    The exit code to terminate the script with. Default is 0, indicating a normal exit.

    .PARAMETER ExitMessage
    Optional custom message to display before exiting.

    .EXAMPLE
    ScriptExit -ExitCode 1 -ExitMessage "An unexpected error occurred."

    .EXAMPLE
    ScriptExit  # This will exit with a code of 0 (indicating success).
    #>

    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        [int]$ExitCode = 0,

        [Parameter(Position = 1)]
        [String]$ExitMessage = "Exiting script with exit code $ExitCode"
    )

    if ($ExitCode -eq 0) {
        Write-Host $ExitMessage -ForegroundColor Green
    } else {
        Write-Warning $ExitMessage
    }

    exit $ExitCode
}


function Show-UnderDevelopmentMessage {
    <#
    .SYNOPSIS
    Displays a message indicating that a feature is under development.
    
    .DESCRIPTION
    Used for menu options that are placeholders for future functionality.
    #>

    Write-Host ''
    Write-Warning 'Feature under development.'
    PauseForUser
}


function Show-InvalidInput {
    <#
    .SYNOPSIS
    Notifies the user of an invalid input.

    .DESCRIPTION
    This function provides a visual cue and pauses the script to inform the user about an invalid input.
    It will display a warning message and await user confirmation before proceeding.

    .EXAMPLE
    Show-InvalidInput
    #>

    [CmdletBinding()]
    param (
        [Parameter(Position = 0, ValueFromPipeline = $True)]
        [String]$CustomMessage = 'Invalid entry detected.'
    )

    Write-Host "`n" -NoNewline
    Write-Warning $CustomMessage
    Read-Host 'Press enter to continue...'
}


function Select-BlankVM-Menu {
    <#
    .SYNOPSIS
    BlankVM OS selection menu loop for user interaction.

    .DESCRIPTION
    This function loops continuously, displaying the OS selection menu and processing user input.
    #>

    while ($True) {
        Show-BlankVM-Menu
        Write-Host ''

        $choice = Read-Host 'Enter your choice'
        Switch ($choice) {
            '1' { BlankVM_exec -OperatingSystem 'Windows' }
            '2' { BlankVM_exec -OperatingSystem 'Linux' }
            'b' { Select-main_Menu }
            'q' { Write-Host '' ; ScriptExit -ExitCode 0 }
            default { Show-InvalidInput }
        }
    }
}


function Show-BlankVM-Menu {
    <#
    .SYNOPSIS
    Displays the OS selection menu for the BlankVM Menu of Hyper-V Toolbox.

    .DESCRIPTION
    This function shows the user a list of operating systems they can choose from.
    #>

    $banner = Show-Banner -BannerType "Window_Banners"
    $menuItems = @(
        "1 - Windows",
        "2 - Linux",
        "",
        "b - Back",
        "q - Quit the program."
    )

    [console]::Clear()
    $banner
    Write-Host "`nHyper-V Toolbox - Blank VM Menu - OS selection"
    Write-Host ('-' * 30)

    $menuItems | ForEach-Object { Write-Host $_ }
}


function BlankVM_exec {
    <#
    .SYNOPSIS
    Creates a new virtual machine based on the provided operating system.
    
    .DESCRIPTION
    The BlankVM_exec function processes the creation of a new virtual machine using the specified operating system. It defines paths and URLs based on the selected operating system, checks the VM links, and sets up and creates the new VM. This function serves as a wrapper and orchestrator for the VM creation process.
    
    .PARAMETER OperatingSystem
    Specifies the operating system type for the virtual machine. Acceptable values are "Windows" and "Linux". This parameter is mandatory.
    
    .EXAMPLE
    BlankVM_exec -OperatingSystem 'Windows'
    
    This command creates a new virtual machine with a Windows operating system.
    
    .EXAMPLE
    BlankVM_exec -OperatingSystem 'Linux'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True)]
        [ValidateSet('Windows', 'Linux')]
        [String]$OperatingSystem
    )

    DefinePathsAndURLs -OperatingSystem $OperatingSystem -Type Blank

    ProcessVMLinks

    SetupAndCreateVM -OperatingSystem $OperatingSystem -Type Blank
}


function DefinePathsAndURLs {
    <#
    .SYNOPSIS
    Defines the paths and URLs based on the provided operating system and VM type.

    .DESCRIPTION
    The DefinePathsAndURLs function determines the appropriate paths and URLs for assets and link files based on the provided operating system type (Windows or Linux) and VM type (Blank or Preconfigured). The function uses a nested hashtable mapping for a cleaner lookup of paths and URLs. It sets the paths and URLs as Global variables for subsequent use in other functions.

    .PARAMETER OperatingSystem
    Specifies the operating system type for which the paths and URLs are to be defined. Acceptable values are "Windows" and "Linux". This parameter is mandatory.

    .PARAMETER Type
    Specifies the type of VM for which the paths and URLs are to be defined. Acceptable values are "Blank" and "Preconfigured". This parameter is mandatory.

    .EXAMPLE
    DefinePathsAndURLs -OperatingSystem 'Windows' -Type 'Blank'
    This command determines the paths and URLs for assets and link files related to the Windows operating system with a Blank VM type.

    .EXAMPLE
    DefinePathsAndURLs -OperatingSystem 'Linux' -Type 'Preconfigured'
    #>

    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Windows', 'Linux')]
        [String]$OperatingSystem,

        [Parameter(Mandatory = $true)]
        [ValidateSet('Blank', 'Preconfigured')]
        [String]$Type
    )

    $osMap = @{
        'Windows' = @{
            'Blank' = @{
                'JSONPath' = '.\assets\links\blank_windows.json';
                'URL'      = $Blank_Windows_JSON_LinksFile;
            }
            'Preconfigured' = @{
                'JSONPath' = '.\assets\links\preconfigured_windows.json';
                'URL'      = $Preconfigured_Windows_JSON_LinksFile;
            }
        }
        'Linux'   = @{
            'Blank' = @{
                'JSONPath' = '.\assets\links\blank_linux.json';
                'URL'      = $Blank_Linux_JSON_LinksFile;
            }
            'Preconfigured' = @{
                'JSONPath' = '.\assets\links\preconfigured_linux.json';
                'URL'      = $Preconfigured_Linux_JSON_LinksFile;
            }
        }
    }

    $Script:JSONFilePath = $osMap[$OperatingSystem][$Type]['JSONPath']
    $Script:JSONFileURL  = $osMap[$OperatingSystem][$Type]['URL']
}

function Ensure-Directory {
    <#
    .SYNOPSIS
    Ensures that a directory exists at the specified path.

    .DESCRIPTION
    The Ensure-Directory function checks if a directory exists at the provided path. If the directory doesn't exist, it attempts to create it. If there's an error during the creation process, it raises an error and exits the script.

    .PARAMETER Path
    Specifies the path of the directory to check or create. This parameter is mandatory.

    .EXAMPLE
    Ensure-Directory -Path ".\assets\links"

    This command checks if the ".\assets\links" directory exists. If not, it creates the directory.
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$Path
    )

    if (-not (Test-Path $Path -PathType Container)) {
        try {
            New-Item -Path $Path -ItemType Directory -Force -ErrorAction Stop | Out-Null
        }
        catch {
            Write-Error "Failed to create directory '$Path': $_"
            ScriptExit -ExitCode 1
        }
    }
}

function Get-GDriveFileID {
    <#
    .SYNOPSIS
    Transforms a Google Drive shared link into a direct download link.

    .DESCRIPTION
    The Get-GDriveFileID function converts a Google Drive shared link into a direct download link format. If the input link is already in the correct format or is not a Google Drive link, the function might return the input link or $null.

    .PARAMETER DriveFileSource
    Specifies the Google Drive shared link that needs to be transformed. This parameter is mandatory.

    .EXAMPLE
    Get-GDriveFileID -DriveFileSource "https://drive.google.com/file/d/FILE_ID/view?usp=sharing"

    This command transforms the provided Google Drive shared link into a direct download link.
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$DriveFileSource
    )

    if ($DriveFileSource.Contains('download&id')) {
        # Return the link as it already seems to be in the desired format.
        return $DriveFileSource
    } elseif ($DriveFileSource -match "drive\.google\.com/file/d/([^/]+)/") {
        $GFileID = $matches[1]
        [String]$GDriveUrl = "https://drive.google.com/uc?export=download&id=$GFileID"
        return $GDriveUrl
    } else {
        # Return $null if the link is not in the expected Google Drive format.
        return $null
    }
}


function Ensure-JSONDirectory {
    <#
    .SYNOPSIS
    Ensures the presence of a JSON file, and if not found, initiates a download.

    .DESCRIPTION
    The Ensure-JSONDirectory function checks for the existence of a specified JSON file at the given destination path. If the file doesn't exist, the function attempts to download it from the specified source.

    .PARAMETER JSONFilePathDestination
    Specifies the path where the JSON file is expected to be located or where it should be downloaded.

    .PARAMETER JSONFileDownloadSource
    Specifies the source URL from where the JSON file should be downloaded if it's not found at the destination.

    .EXAMPLE
    Ensure-JSONDirectory -JSONFilePathDestination "\assets\links\blank_windows.json" -JSONFileDownloadSource "https://example.com/links.json"
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$JSONFilePathDestination,
        
        [Parameter(Mandatory = $true)]
        [String]$JSONFileDownloadSource
    )

    if (-not (Test-Path $JSONFilePathDestination)) {
        Write-Host "`nAttempting to download the JSON configuration file containing image links."
        try {
            Invoke-WebRequest -Uri $JSONFileDownloadSource -OutFile $JSONFilePathDestination -TimeoutSec 5 -UseBasicParsing
            Write-Host "JSON file successfully downloaded.`n"
            PauseForUser
        } catch {
            Write-Error "Error downloading the JSON file: $_"
            ScriptExit -ExitCode 1
        }
    }
}


function Read-FromJSON {
    <#
    .SYNOPSIS
    Reads the contents of a JSON file and returns it as a PowerShell object.

    .DESCRIPTION
    The Read-FromJSON function takes the path to a JSON file as its input. It checks if the file exists and then reads its content, converting it to a PowerShell object before returning it. If the file is not found, or another error occurs, the function provides an error message and exits the script.

    .PARAMETER JSONFilePathDestination
    Specifies the path to the JSON file that needs to be read.

    .EXAMPLE
    $myData = Read-FromJSON -JSONFilePathDestination ".\assets\links\blank_windows.json"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$JSONFilePathDestination
    )

    if (-not (Test-Path $JSONFilePathDestination)) {
        Write-Warning "JSON configuration file not found at '$JSONFilePathDestination'."
        ScriptExit -ExitCode 1
    }
    
    try {
        $JSONContent = Get-Content -Path $JSONFilePathDestination -Raw
        $JSONdata = $JSONContent | ConvertFrom-Json
        return $JSONdata
    }
    catch {
        Write-Error "Error reading or converting the JSON file: $_"
        ScriptExit -ExitCode 1
    }
}


function Check-VMLinks {
    <#
    .SYNOPSIS
    Checks and processes VM links from the provided JSON file and its URL.

    .DESCRIPTION
    The Check-VMLinks function verifies and processes the Virtual Machine (VM) links based on the provided JSON file path and its corresponding URL. The function ensures the destination directory for the JSON file exists and fetches the file if the URL corresponds to a Google Drive link. After validating and downloading the JSON, it reads its contents into a script-wide MenuItems array for subsequent operations.

    .PARAMETER JSONFilePath
    Specifies the local path where the JSON file with VM links resides or should be downloaded to. This parameter is mandatory.

    .PARAMETER JSONFileURL
    Specifies the URL where the VM links' JSON file can be fetched or verified. This parameter is mandatory.

    .EXAMPLE
    Check-VMLinks -JSONFilePath ".\assets\links\blank_windows.json" -JSONFileURL "https://example.com/blank_windows.json"
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$JSONFilePath,
        
        [Parameter(Mandatory = $true)]
        [String]$JSONFileURL
    )

    $JSONDirectory = Split-Path -Path $JSONFilePath
    Ensure-Directory -Path $JSONDirectory

    [String]$Url = $JSONFileURL
    if ($Url -match "drive\.google\.com") { 
        $Url = Get-GDriveFileID -DriveFileSource $Url 
    }

    try {
        [void](Ensure-JSONDirectory -JSONFilePathDestination $JSONFilePath -JSONFileDownloadSource $Url)
    }
    catch {
        Write-Warning "Error occurred during JSON file download: $_"
        ScriptExit -ExitCode 1
    }

    # Read the contents of the downloaded/verified JSON into a script-wide variable
    [Array]$Script:MenuItems = Read-FromJSON -JSONFilePathDestination $JSONFilePath
}


function Invoke-GDriveFileRequest {
    <#
    .SYNOPSIS
    Downloads a file from a Google Drive sharing link using the BITS transfer service.

    .DESCRIPTION
    This function allows you to download a file from a Google Drive sharing link. It retrieves the actual download URL from the link's webpage and initiates the download using the Background Intelligent Transfer Service (BITS). The downloaded file is saved to the specified destination path.

    .PARAMETER Url
    Specifies the Google Drive sharing link from which to download the file. This parameter is mandatory.

    .PARAMETER Destination
    Specifies the local path where the downloaded file will be saved. This parameter is mandatory.

    .PARAMETER DisplayName
    Specifies the display name for the BITS transfer job. The default is 'Hyper-V Toolbox - Downloader'.

    .PARAMETER Description
    Specifies the description for the BITS transfer job. By default, it includes information about the download, such as the title, source URL, and destination path.

    .EXAMPLE
    Invoke-GDriveFileRequest -Url 'https://drive.google.com/file/d/yourfileid/view?usp=sharing' -Destination 'C:\Users\$env:USERNAME\Downloads'
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [String]$Url,
        
        [Parameter(Mandatory=$true)]
        [String]$Destination,
        
        [String]$DisplayName = 'Hyper-V Toolbox - Downloader',
        
        [String]$Description = "Downloading of : $Title - From : $Url - To : $OutputPath"
    )

    $WebClient = New-Object System.Net.WebClient
    $DownloadPageContent = $WebClient.DownloadString($Url)

    $regex = 'action="([^"]*)"'
    $match = [regex]::Match($DownloadPageContent, $regex)

    if ($match.Success) {
        $downloadUrl = $match.Groups[1].Value
        Write-Verbose "Download URL found: $downloadUrl"
    } else {
        Write-Warning 'Download URL not found.'
        return
    }

    Add-Type -AssemblyName System.Web
    $DownloadLink = [System.Web.HttpUtility]::HtmlDecode($downloadUrl)

    Start-BitsTransfer -Source $DownloadLink -Destination $Destination -DisplayName $DisplayName -Description $Description

    [String]$script:Url = $DownloadLink
}


function Show-Downloadable-VM {
    <#
    .SYNOPSIS
    Displays a menu of downloadable virtual machines and handles user choice.

    .DESCRIPTION
    This function clears the console and presents the user with a list of 
    downloadable virtual machines. The user can then choose to download one of 
    the VMs, cancel the operation, return to the main menu, or exit the script.

    .PARAMETER None
    No parameters are passed directly to this function. Instead, it relies on 
    script-level variables like $MenuItems.
    #>

    [console]::Clear()

    $BannerType = Get-Random -InputObject $Space_Banners ; Show-Banner $BannerType

    Write-Host ''
    Write-Host 'Hyper-V Toolbox'
    Write-Host '--------------------'

    # Display menu items
    for ($i = 0; $i -lt $MenuItems.Count; $i++) { 
        Write-Host " $($i + 1). $($MenuItems[$i].Title)" 
    }

    Write-Host ''
    $choice = Read-Host "Enter your choice [1-$($MenuItems.Count)], 'c' to cancel, 'b' to go back to the 'Blank VM Menu' OS selection, or 'Q' to quit"

    switch ($choice.ToLower()) {
        'c' {
            Select-main_Menu
            return
        }
        'b' {
            Select-BlankVM-Menu
            return
        }
        'q' {
            Write-Host '' ; ScriptExit -ExitCode 0
            return
        }

        default {
            $index = [int]$choice - 1

            if ($index -ge 0 -and $index -lt $MenuItems.Count) {
                $Url = $MenuItems[$index].Url

                [String]$script:Title = $MenuItems[$index].Title
                [String]$script:Filename = $MenuItems[$index].Filename
                [String]$script:OutputDirectory = '.\assets\images'
                [String]$script:OutputPath = Join-Path -Path $OutputDirectory -ChildPath $Filename

                # Ensure output directory exists
                if (-not (Test-Path $OutputDirectory)) { 
                    [void](New-Item -Path $OutputDirectory -ItemType Directory -Force) 
                }

                # File download logic
                if (-not (Test-Path $OutputPath)) {
                    # Google Drive-specific logic
                    if ($Url -match "drive\.google\.com") {
                        $Url = Get-GDriveFileID -DriveFileSource $Url
                        Invoke-GDriveFileRequest -Url $Url -DisplayName 'Hyper-V Toolbox - Downloader' -Destination $OutputPath -Description "Downloading of : $Title - From : $Url - To : $OutputPath"
                    } else {
                        # Generic download logic with retries
                        [Byte]$maxRetries = 3
                        [Byte]$retryInterval = 5 # seconds
                        [Byte]$retryCount = 0
                        do {
                            try {
                                Write-Host '' ; Write-Warning "$Title ($Filename) has not been found in $OutputPath. Initiating download..." ; Write-Host ''
                                Start-BitsTransfer -Source $Url -Destination $OutputPath -DisplayName 'Hyper-V Toolbox - Downloader' -Description "Downloading of: $Title - From: $Url - To: $OutputPath" -TransferType Download -TransferPolicy Unrestricted
                                if (-not (Test-Path $OutputPath)) {
                                    Write-Host ''
                                    Write-Error "An error occurred during the download of $Title ($Filename)."
                                    ScriptExit -ExitCode 1
                                } else {
                                Write-Warning "$Title ($Filename) has been successfully downloaded to: $OutputPath."
                                Write-Host '' ; PauseForUser
                                break
                                }
                            } catch {
                                $retryCount++
                                if ($retryCount -lt $maxRetries) {
                                    Write-Host ''
                                    Write-Warning "An error occurred during the download of $Title. Retrying in $retryInterval seconds..."
                                    Start-Sleep -Seconds $retryInterval
                                } else {
                                    Write-Host ''
                                    Write-Error "Failed to download $Title after $maxRetries attempts."
                                    ScriptExit -ExitCode 1
                                }
                            }
                        } while ($retryCount -lt $maxRetries)
                    }
                }
            } else {
                Show-InvalidInput
                Show-Downloadable-VM
            }
        }
    }
}


function ProcessVMLinks {
    <#
    .SYNOPSIS
    Processes and displays VM links for download.

    .DESCRIPTION
    The function coordinates the process of checking for VM links 
    within a specified JSON file and then displays a menu for the 
    user to select and download a virtual machine. 

    It first validates the links using the Check-VMLinks function 
    and then presents the available VMs using the Show-Downloadable-VM function.

    .PARAMETER None
    No parameters are passed directly to this function. Instead, it relies on 
    script-level variables such as $Script:JSONFilePath and $Script:JSONFileURL.

    .EXAMPLE
    ProcessVMLinks
    #>

    Check-VMLinks -JSONFilePath $Script:JSONFilePath -JSONFileURL $Script:JSONFileURL
    Show-Downloadable-VM
}


function Ensure-BasicResource {
    <#
    .SYNOPSIS
    Ensures the presence of essential directories required for VM resources.

    .DESCRIPTION
    The Ensure-BasicResource function verifies the existence of vital directories 
    necessary for the Hyper-V Toolbox to function correctly. If the specified 
    directories do not exist, the function will create them.

    The function primarily checks and sets up directories for Virtual Hard Disks (VHDs) 
    and VMs (Virtual Machines) resources. 

    By default, these directories are:
    - '.\assets\resources\vhds' for VHDs.
    - '.\assets\resources\vms' for VMs.

    .PARAMETER VHDPath
    Specifies the path for storing Virtual Hard Disks (VHDs). By default, this path is '.\assets\resources\vhds'.

    .PARAMETER VMsPath
    Specifies the path for storing VM configurations and resources. By default, this path is '.\assets\resources\vms'.

    .EXAMPLE
    Ensure-BasicResource

    .EXAMPLE
    Ensure-BasicResource -VHDPath "D:\VHDs" -VMsPath "D:\VMs"
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [String]$VHDPath = '.\assets\resources\vhds',
        [Parameter(Mandatory=$false)]
        [String]$VMsPath = '.\assets\resources\vms'
    )

    $directories = @($VHDPath, $VMsPath)

    try {
        foreach ($directory in $directories) {
            if (-not (Test-Path $directory)) {
                New-Item -ItemType Directory -Path $directory -ErrorAction Stop | Out-Null
            }
        }
    }
    catch {
        Write-Error "Error when creating directories: $_"
        ScriptExit -ExitCode 1
    }
}


function Set-BlankVM {
    <#
    .SYNOPSIS
    Configures settings for a blank virtual machine (VM) based on the specified operating system.

    .DESCRIPTION
    The Set-BlankVM function configures settings for creating a blank VM. This includes selecting banners, setting the VM name, virtual switch, RAM size, and hard disk size based on the operating system.

    .PARAMETER OperatingSystem
    The type of operating system for which the VM settings will be configured. Supported values are 'Windows' and 'Linux'.

    .EXAMPLE
    Set-BlankVM -OperatingSystem 'Windows'
    Configures settings for a blank Windows VM.

    .EXAMPLE
    Set-BlankVM -OperatingSystem 'Linux'
    Configures settings for a blank Linux VM.
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet('Windows', 'Linux')]
        [String]$OperatingSystem
    )

    [console]::Clear()
    $banners = if ($OperatingSystem -eq 'Windows') { $Windows_Banners } else { $Linux_Banners }
    Write-Host (Get-RandomBanner -Banners $banners)
    PauseForUser
    Write-Host ''
    Write-Host 'Hyper-V Toolbox'
    Write-Host '--------------------'

    Check-OSType

    if ($OperatingSystemType -eq 'Client') {
        $Prefix = "VM-$OperatingSystem-$OperatingSystemType"
    } elseif ($OperatingSystemType -eq 'Server') {
        $Prefix = "VM-$OperatingSystem-$OperatingSystemType"
    } else {
        $Prefix = "VM-$OperatingSystem"
    }

    Set-Name -Prefix $Prefix
    $script:Prefix = $Prefix

    Set-VSwitch
    Write-Host ''

    [Array]$RAMSizes = if ($OperatingSystem -eq 'Windows') { @('1GB', '2GB', '4GB', '8GB', '16GB') } else { @('1GB', '2GB', '4GB', '8GB', '16GB', '32GB') }
    [Byte]$DefaultRAMSizeChoiceIndex = if ($OperatingSystem -eq 'Windows') { 1 } else { 0 }
    Set-RAMSize -RAMSizes $RAMSizes -DefaultRAMSizeChoice $DefaultRAMSizeChoiceIndex
    Write-Host ''

    [Array]$HDDSizes = if ($OperatingSystem -eq 'Windows') { @('8GB', '16GB', '32GB', '64GB', '128GB', '256GB') } else { @('8GB', '16GB', '32GB', '64GB', '128GB', '256GB', '512GB') }
    [Byte]$DefaultHDDSizeChoiceIndex = if ($OperatingSystem -eq 'Windows') { 2 } else { 1 }
    Set-HDDSize -HDDSizes $HDDSizes -DefaultHDDSizeChoice $DefaultHDDSizeChoiceIndex
    Write-Host ''
}


function SetupAndCreateVM {
    <#
    .SYNOPSIS
    Sets up and creates a virtual machine based on the provided type.

    .DESCRIPTION
    The SetupAndCreateVM function sets up and creates a virtual machine (VM) of a specified type (either Blank or Preconfigured). 
    It ensures necessary resources are available, sets VM parameters based on the type, creates the VM, shows an animated banner, 
    performs additional VM tasks, and displays the VM's status.

    .PARAMETER OperatingSystem
    Specifies the operating system for the VM.

    .PARAMETER Type
    Specifies the type of VM to create. Accepts either 'Blank' or 'Preconfigured'.

    .EXAMPLE
    SetupAndCreateVM -OperatingSystem 'Windows10' -Type 'Blank'
    Creates a blank Windows 10 VM.

    .EXAMPLE
    SetupAndCreateVM -OperatingSystem 'Ubuntu20.04' -Type 'Preconfigured'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$OperatingSystem,
        
        [Parameter(Mandatory = $true)]
        [ValidateSet("Blank", "Preconfigured")]
        [String]$Type
    )

    # Ensure all necessary resources are in place.
    Ensure-BasicResource

    switch ($Type) {
        "Blank" {
            Set-BlankVM -OperatingSystem $OperatingSystem
            New-BlankVM
        }
        "Preconfigured" {
            Set-PreconfiguredVM -OperatingSystem $OperatingSystem
            New-PreconfiguredVM
        }
    }

    Show-AnimatedBanner -AnimatedBanners $AnimatedPacman_Banner
    New-VMAdditionalTasks -VMName $Script:VMName -OutputPath $Script:OutputPath -VMType $OperatingSystem

    # Display the VM status.
    Show-CreatedVMStatus -VMType $OperatingSystem
}


function Show-main_Menu {
    <#
    .SYNOPSIS
    Displays the main menu for the Hyper-V Toolbox.

    .DESCRIPTION
    This function shows the user a list of options they can choose from.
    #>

    $banner = Show-Banner -BannerType "Buddha"
    $menuItems = @(
        "1 - Create a virtual machine",
        "2 - Create a preconfigured virtual machine from a template [Under development]",
        "",
        "3 - Creation of laboratories [Under development]",
        "",
        "4 - Management of virtual machines [Under development]",
        "5 - Management of virtual Switches [Under development]",
        "6 - Management of local resources [Under development]",
        "",
        "h - Show help",
        "q - Quit the program."
    )

    [console]::Clear()
    $banner
    Write-Host "`nHyper-V Toolbox - Main menu"
    Write-Host ('-' * 30)

    $menuItems | ForEach-Object { Write-Host $_ }
}


function main {
    param (
    )

    <#
    .SYNOPSIS
    Main function for the script execution.

    .DESCRIPTION
    The function acts as the main entry point for script logic. It checks if the user has administrator rights before proceeding with the rest of the script.
    #>

    [console]::Clear()

    # Check for Admin Rights
    if (-not (Test-AdminRights)) {
        Write-Error "This script requires administrator rights."
        return
    }

    # Check for Prerequisites
    if (-not (Test-Prerequisites)) {
        Write-Warning "Some prerequisites are missing. Please ensure they are installed before proceeding."
        return
    }

    # Check for WAN Status
    $wanStatus = Get-WANStatus
    if ($wanStatus -eq "Online") {
        Write-Host "Connected to the internet, proceeding with the update check..."

        # Check for Script Updates
        $updateStatus = Get-Update
        if ($updateStatus -eq $True) {
            Write-Host "A new version of the script is available. Please consider updating."
        } else {
            Write-Host "You're using the latest version of the script."
        }

    } else {
        Write-Warning "Not connected to the internet. Skipping the update check."
    }

    Write-Host '' ; PauseForUser

    Select-main_Menu
}


# Hyper-V Toolbox entry point.
if ($help) {
    Display-Help
} else {
    main
}
