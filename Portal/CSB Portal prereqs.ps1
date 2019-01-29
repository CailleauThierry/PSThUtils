# Validate pre-requisites for Carbonite Server Backup Portal 8-60
# Modified by Philippe Gilli in Jan 2019 from script shared by Patrick Voogt on 11/19/2018

# * Run this script from a Powershel Admin Prompt!
# * Make sure Powershell Execution Policy is bypassed to run these scripts:
# * YOU MAY HAVE TO RUN THIS COMMAND PRIOR TO RUNNING THIS SCRIPT!
Set-ExecutionPolicy Bypass -Scope Process


# Check .NET-Framework (3.5 and 4.5)
Get-Windowsfeature NET-Framework-Core
Get-WindowsFeature NET-Framework-45-Core

# Check the status of other required Windows features
get-WindowsFeature NET-HTTP-Activation
get-WindowsFeature NET-WCF-HTTP-Activation45
get-WindowsFeature WAS-Process-Model
get-WindowsFeature WAS-Config-APIs
# Install State should be "Installed". If state is "Available", it needs to be installed.
# Replace Get with Install. For example: Install-Windowsfeature NET-HTTP-Activation

# Check the status of all required Windows optional features
get-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole
get-WindowsOptionalFeature -Online -FeatureName IIS-WebServer
get-WindowsOptionalFeature -Online -FeatureName IIS-CommonHttpFeatures
get-WindowsOptionalFeature -Online -FeatureName IIS-HttpErrors
get-WindowsOptionalFeature -Online -FeatureName IIS-HttpRedirect
get-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment
get-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility45
get-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility
get-WindowsOptionalFeature -Online -FeatureName IIS-HealthAndDiagnostics
get-WindowsOptionalFeature -Online -FeatureName IIS-HttpLogging
get-WindowsOptionalFeature -Online -FeatureName IIS-LoggingLibraries
get-WindowsOptionalFeature -Online -FeatureName IIS-RequestMonitor
get-WindowsOptionalFeature -Online -FeatureName IIS-HttpTracing
get-WindowsOptionalFeature -Online -FeatureName IIS-Security
get-WindowsOptionalFeature -Online -FeatureName IIS-RequestFiltering
get-WindowsOptionalFeature -Online -FeatureName IIS-Performance
get-WindowsOptionalFeature -Online -FeatureName IIS-WebServerManagementTools
get-WindowsOptionalFeature -Online -FeatureName IIS-IIS6ManagementCompatibility
get-WindowsOptionalFeature -Online -FeatureName IIS-Metabase
get-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole
get-WindowsOptionalFeature -Online -FeatureName IIS-BasicAuthentication
get-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication
get-WindowsOptionalFeature -Online -FeatureName IIS-StaticContent
get-WindowsOptionalFeature -Online -FeatureName IIS-DefaultDocument
get-WindowsOptionalFeature -Online -FeatureName IIS-WebSockets
get-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationInit
get-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIExtensions
get-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIFilter
get-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionStatic
get-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET45
get-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET
get-WindowsOptionalFeature -online -FeatureName NetFx4Extended-ASPNET45

# State should be Enabled. If state is disabled the feature needs to be installed.
# Replace Get with Enable. For example: Enable-WindowsOptionalFeature -Online -FeatureName Web-ISAPI-Ext

Pause