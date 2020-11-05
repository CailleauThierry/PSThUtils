# Set-PortalRequirement.ps1 on Thursday November 05, 2020
# Validate pre-requisites for Carbonite Server Backup Portal 8-60
# * Run this script from a Powershel Admin Prompt!
# * Make sure Powershell Execution Policy is bypassed to run these scripts:
# * YOU MAY HAVE TO RUN THIS COMMAND PRIOR TO RUNNING THIS SCRIPT!
Set-ExecutionPolicy Bypass -Scope Process


# Check .NET-Framework (3.5 and 4.5)
Set-Windowsfeature NET-Framework-Core
Set-WindowsFeature NET-Framework-45-Core

# Check the status of other required Windows features
Set-WindowsFeature NET-HTTP-Activation
Set-WindowsFeature NET-WCF-HTTP-Activation45
Set-WindowsFeature WAS-Process-Model
Set-WindowsFeature WAS-Config-APIs
# Install State should be "Installed". If state is "Available", it needs to be installed.
# Replace Get with Install. For example: Install-Windowsfeature NET-HTTP-Activation

# Check the status of all required Windows optional features
Set-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole
Set-WindowsOptionalFeature -Online -FeatureName IIS-WebServer
Set-WindowsOptionalFeature -Online -FeatureName IIS-CommonHttpFeatures
Set-WindowsOptionalFeature -Online -FeatureName IIS-HttpErrors
Set-WindowsOptionalFeature -Online -FeatureName IIS-HttpRedirect
Set-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment
Set-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility45
Set-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility
Set-WindowsOptionalFeature -Online -FeatureName IIS-HealthAndDiagnostics
Set-WindowsOptionalFeature -Online -FeatureName IIS-HttpLogging
Set-WindowsOptionalFeature -Online -FeatureName IIS-LoggingLibraries
Set-WindowsOptionalFeature -Online -FeatureName IIS-RequestMonitor
Set-WindowsOptionalFeature -Online -FeatureName IIS-HttpTracing
Set-WindowsOptionalFeature -Online -FeatureName IIS-Security
Set-WindowsOptionalFeature -Online -FeatureName IIS-RequestFiltering
Set-WindowsOptionalFeature -Online -FeatureName IIS-Performance
Set-WindowsOptionalFeature -Online -FeatureName IIS-WebServerManagementTools
Set-WindowsOptionalFeature -Online -FeatureName IIS-IIS6ManagementCompatibility
Set-WindowsOptionalFeature -Online -FeatureName IIS-Metabase
Set-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole
Set-WindowsOptionalFeature -Online -FeatureName IIS-BasicAuthentication
Set-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication
Set-WindowsOptionalFeature -Online -FeatureName IIS-StaticContent
Set-WindowsOptionalFeature -Online -FeatureName IIS-DefaultDocument
Set-WindowsOptionalFeature -Online -FeatureName IIS-WebSockets
Set-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationInit
Set-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIExtensions
Set-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIFilter
Set-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionStatic
Set-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET45
Set-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET
Set-WindowsOptionalFeature -online -FeatureName NetFx4Extended-ASPNET45

# State should be Enabled. If state is disabled the feature needs to be installed.
# Replace Get with Enable. For example: Enable-WindowsOptionalFeature -Online -FeatureName Web-ISAPI-Ext

Pause