

Hosted on `m370prd1` under [http://m370prd1/nuget/nuget](http://m370prd1/nuget/nuget). Packages can be copied to `D:\inetpub\nuget\Packages`.

The source code can be found in the `flaming-octo-dangerzone` repository under the `moe-next\packages\EUC.Nuget` folder.

There are a number of [blog posts](http://learn-powershell.net/2014/04/11/setting-up-a-nuget-feed-for-use-with-oneget/) on how to roll your own Nuget server, but in a nutshell it required creating an empty web application in Visual Studio, adding the `Nuget.Server` package, and compiling it.

# Adding a PowerShell Package Management Repository

~~~~ ps1
Register-PSRepository -Name EUC -SourceLocation http://m370prd1/nuget/nuget -PackageManagementProvider nuget
~~~~