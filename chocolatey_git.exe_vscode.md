chocolatey_git.exe_vscode.md
Edited: 05_06_2020
Author: Thiery Cailleau

chocolatey -----------------------

1. First, ensure that you are using an administrative shell - you can also install as a non-admin, check out Non-Administrative Installation.
2. Install with powershell.exe
NOTE: Please inspect https://chocolatey.org/install.ps1 prior to running any of these scripts to ensure safety. We already know it's safe, but you should verify the security and contents of any script from the internet you are not familiar with. All of these scripts download a remote PowerShell script and execute it on your machine. We take security very seriously. Learn more about our security protocols.
With PowerShell, you must ensure Get-ExecutionPolicy is not Restricted. We suggest using Bypass to bypass the policy to get things installed or AllSigned for quite a bit more security.
	○ Run Get-ExecutionPolicy. If it returns Restricted, then run Set-ExecutionPolicy AllSigned or Set-ExecutionPolicy Bypass -Scope Process.
Now run the following command:

Copy:
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) 

to Clipboard

3. Paste the copied text into your shell and press Enter.
4. Wait a few seconds for the command to complete.
5. If you don't see any errors, you are ready to use Chocolatey! Type choco or choco -? now, or see Getting Started for usage instructions.

From <https://chocolatey.org/install>

vscode --------------------------------

Adding { "git.path":"d:\\Program Files\\Git\\bin\\gite.exe" } did the job

From <https://stackoverflow.com/questions/29971624/visual-studio-code-cannot-detect-installed-git>


{    
    "git.path":"C:\\Users\\Administrator\\AppData\\Local\\GitHubDesktop\\app-2.4.0\\resources\\app\\git\\cmd\\git.exe",
    "telemetry.enableTelemetry": false,
    "terminal.integrated.shell.windows": "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
    "files.autoSave": "afterDelay",
    "git.enableSmartCommit": true,
    "git.autofetch": true
}

C:\\Users\\Administrator\\AppData\\Local\\GitHubDesktop\\app-2.4.0\\resources\\app\\git\\cmd\\git.exe" is the path for git installed by GitHub Dekstop and is sufficient for vscode integration