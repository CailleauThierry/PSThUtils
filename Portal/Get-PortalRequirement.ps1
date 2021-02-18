# Get-PortalRequirement.ps1 on Thursday November 05, 2020
# Validate pre-requisites for Carbonite Server Backup Portal 8-60

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

<# 
REsult after everything is installed:
> c:\Users\Administrator\Documents\WindowsPowerShell\Scripts\PSThUtils\Portal\Get-PortalRequirement.ps1

Display Name                                            Name                       Install State
------------                                            ----                       -------------
    [X] .NET Framework 3.5 (includes .NET 2.0 and 3.0)  NET-Framework-Core             Installed
    [X] .NET Framework 4.6                              NET-Framework-45-Core          Installed
    [X] HTTP Activation                                 NET-HTTP-Activation            Installed
        [X] HTTP Activation                             NET-WCF-HTTP-Activat...        Installed
    [X] Process Model                                   WAS-Process-Model              Installed
    [X] Configuration APIs                              WAS-Config-APIs                Installed

FeatureName      : IIS-WebServerRole
State            : Enabled
DisplayName      : Internet Information Services
Description      : Internet Information Services provides support for Web and FTP servers, along with support for dynamic content such as Classic ASP
                   and CGI, and local management.
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, EventQuery, Id...}


FeatureName      : IIS-WebServer
State            : Enabled
DisplayName      : World Wide Web Services
Description      : Installs the IIS 10.0 World Wide Web Services. Provides support for HTML web sites and optional support for Classic ASP, and web
                   server extensions.
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, InstallWithParentByDefault...}


FeatureName      : IIS-CommonHttpFeatures
State            : Enabled
DisplayName      : Common HTTP Features
Description      : Installs support for Web server content such as HTML and image files.
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, InstallWithParentByDefault...}


FeatureName      : IIS-HttpErrors
State            : Enabled
DisplayName      : HTTP Errors
Description      : Allows you to customize the error messages returned to clients
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, InstallWithParentByDefault...}


FeatureName      : IIS-HttpRedirect
State            : Enabled
DisplayName      : HTTP Redirection
Description      : Redirect client requests to a specific destination
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, Parent...}


FeatureName      : IIS-ApplicationDevelopment
State            : Enabled
DisplayName      : Application Development Features
Description      : Install Web server application development features
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, Parent...}


FeatureName      : IIS-NetFxExtensibility45
State            : Enabled
DisplayName      : .NET Extensibility 4.6
Description      : Enable your Web server to host .NET Framework v4.6 applications
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, Parent...}


FeatureName      : IIS-NetFxExtensibility
State            : Enabled
DisplayName      : .NET Extensibility 3.5
Description      : Enable your Web server to host .NET Framework 3.5 applications
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, Parent...}


FeatureName      : IIS-HealthAndDiagnostics
State            : Enabled
DisplayName      : Health and Diagnostics
Description      : Enables you to monitor and manage server, site, and application health
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, InstallWithParentByDefault...}


FeatureName      : IIS-HttpLogging
State            : Enabled
DisplayName      : HTTP Logging
Description      : Enables logging of Web site activity for this server
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, InstallWithParentByDefault...}


FeatureName      : IIS-LoggingLibraries
State            : Enabled
DisplayName      : Logging Tools
Description      : Install IIS 10.0 logging tools and scripts
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, Parent...}


FeatureName      : IIS-RequestMonitor
State            : Enabled
DisplayName      : Request Monitor
Description      : Monitor server, site, and application health
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, InstallWithParentByDefault...}


FeatureName      : IIS-HttpTracing
State            : Enabled
DisplayName      : Tracing
Description      : Enable tracing for ASP.NET applications and failed requests
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, Parent...}


FeatureName      : IIS-Security
State            : Enabled
DisplayName      : Security
Description      : Enable additional security features to secure servers, sites, applications, vdirs, and files
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, InstallWithParentByDefault...}


FeatureName      : IIS-RequestFiltering
State            : Enabled
DisplayName      : Request Filtering
Description      : Configure rules to block selected client requests.
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, InstallWithParentByDefault...}


FeatureName      : IIS-Performance
State            : Enabled
DisplayName      : Performance Features
Description      : Install performance features
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, InstallWithParentByDefault...}


FeatureName      : IIS-WebServerManagementTools
State            : Enabled
DisplayName      : Web Management Tools
Description      : Install Web management console and tools
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, Parent...}


FeatureName      : IIS-IIS6ManagementCompatibility
State            : Enabled
DisplayName      : IIS 6 Management Compatibility
Description      : Allows you to use existing IIS 6.0 APIs and scripts to manage this IIS 10.0 web server
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, Parent...}


FeatureName      : IIS-Metabase
State            : Enabled
DisplayName      : IIS Metabase and IIS 6 configuration compatibility
Description      : Install IIS metabase and compatibility layer to allow metabase calls to interact with new IIS 10.0 configuration store
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, InstallWithParentByDefault...}


FeatureName      : IIS-ManagementConsole
State            : Enabled
DisplayName      : IIS Management Console
Description      : Install Web server Management Console which supports management of local and remote Web servers.
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, InstallWithParentByDefault...}


FeatureName      : IIS-BasicAuthentication
State            : Enabled
DisplayName      : Basic Authentication
Description      : Require a valid Windows user name and password for connection.
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, Parent...}


FeatureName      : IIS-WindowsAuthentication
State            : Enabled
DisplayName      : Windows Authentication
Description      : Authenticate clients by using NTLM or Kerberos.
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, Parent...}


FeatureName      : IIS-StaticContent
State            : Enabled
DisplayName      : Static Content
Description      : Serve .htm, .html, and image files from a Web site
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, InstallWithParentByDefault...}


FeatureName      : IIS-DefaultDocument
State            : Enabled
DisplayName      : Default Document
Description      : Allows you to specify a default file to be loaded when users do not specify a file in a request URL
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, InstallWithParentByDefault...}


FeatureName      : IIS-WebSockets
State            : Enabled
DisplayName      : WebSocket Protocol
Description      : IIS 10.0 and ASP.NET 4.6 support writing server applications that communicate over the WebSocket Protocol.
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, Parent...}


FeatureName      : IIS-ApplicationInit
State            : Enabled
DisplayName      : Application Initialization
Description      : Application Initialization perform expensive web application initialization tasks before serving web pages.
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, Parent...}


FeatureName      : IIS-ISAPIExtensions
State            : Enabled
DisplayName      : ISAPI Extensions
Description      : Allow ISAPI extensions to handle client requests
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, Parent...}


FeatureName      : IIS-ISAPIFilter
State            : Enabled
DisplayName      : ISAPI Filters
Description      : Allow ISAPI filters to modify Web server behavior
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, Parent...}


FeatureName      : IIS-HttpCompressionStatic
State            : Enabled
DisplayName      : Static Content Compression
Description      : Compress static content before returning it to a client
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, InstallWithParentByDefault...}


FeatureName      : IIS-ASPNET45
State            : Enabled
DisplayName      : ASP.NET 4.6
Description      : Enable your Web server to host ASP.NET v4.6 applications
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, Parent...}


FeatureName      : IIS-ASPNET
State            : Enabled
DisplayName      : ASP.NET 3.5
Description      : Enable your Web server to host ASP.NET 3.5 applications
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, Parent...}


FeatureName      : NetFx4Extended-ASPNET45
State            : Enabled
DisplayName      : ASP.NET 4.6
Description      : ASP.NET 4.6
RestartRequired  : Possible
CustomProperties : {Description, DisplayName, Id, InstallWithParentByDefault...}

Press Enter to continue...:
#>