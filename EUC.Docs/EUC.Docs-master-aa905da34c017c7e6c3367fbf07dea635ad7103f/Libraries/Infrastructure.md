
# Servers



# Active Directory



# Desired State Configuration

# Proxy
## Standard Proxy
A transparent proxy is available on the Library network. It uses [OpenDns](https://www.opendns.com/) for content filtering.
 `proxy.brisbane.qld.gov.au:3128`. 
 
## Squid on m570prd1
The Squid proxy services hosted on `m570prd1` are at time of writing utilised only by the OPAC PC's; other COE PC's go through the normal proxy hosted mentioned above. This proxy has been configured to only allow a whitelist of domains, to try and prevent users from using an OPAC PC as a general purpose terminal.

### Installation
Squid 2.7-stable8 was downloaded from [http://squid.acmeconsulting.it/Squid27.html](http://squid.acmeconsulting.it/Squid27.html) and installed to `c:\squid`.

### Configuration
The configuration file is stored under `C:\squid\etc\squid.conf`. It is a simple configuration file with no authentication mechanism. The primary differences are:
* a list of allow domains is defined in a file called `alloweddomains` in the same folder
* this list of domains is the only allowed access rule

If a domain is matched in the list of allowed domains, the request is transparently forwarded to the Library proxy server.

~~~~
http_port 3128
visible_hostname m570prd1
access_log c:/squid/var/logs/access.log squid
acl all src all
acl manager proto cache_object
acl localhost src 127.0.0.1/32
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32
acl libnet src 192.168.0.0/255.255.0.0
acl opac url_regex "c:/squid/etc/alloweddomains"
http_access allow opac libnet
~~~~ 

### Allowed Domains
This file is too large to list in full here, but a sample is provided below. There is a PowerShell script in the same folder called `CleanupAllowedDomains.ps1` which will sort the file in to alphabetical order. The master list of allowed domains is stored in source control at `https://github.com/timbodv/flaming-octo-dangerzone/tree/master/libraries/alloweddomains`.

~~~~
10monkeys.com
about.pressreader.com
abs.gov.au
admin.brightcove.com
alexanderstreet.com
ancestrylibrary.com
ancestrylibrary.proquest.com
artfilms-digital.com
articles.brisbanehistory.asn.au
beamafilm.com
bit.ly
bitly.com
blog.pressreader.com
bolindadigital.com
booksinprint.com
brightcove01.brightcove.com
brisbane.qld.gov.au
brisbanecityredesign.prod.acquia-sites.com
britishnewspaperarchive.co.uk
busythings.co.uk
~~~~

#### Search Engine Domains
Why was google.com and yahoo.com added? A lot of sites depende on URL's from these two domains to functions - things like ads, javascript and images. There is a risk of course that users may use these PC's to query Google or Yahoo, however the Library Support team accepted that typically URL's that a user might want to go to from search results would not work because they were not on the whitelist.

### Logs
Log files are stored under `c:\squid\var\logs` predominantly in the `access.log` file. A PowerShell script in the same folder called `Get-LatestDeniedMessages.ps1` will list out recent denied entries; a sample of the output is below.

~~~~
PS C:\squid\var\logs> .\Get-LatestDeniedMessages.ps1
1439958275.940      0 192.168.13.53 TCP_DENIED/403 1121 CONNECT clients2.google.com:443 - NONE/- text/html
1439958298.782      0 192.168.13.53 TCP_DENIED/403 1121 CONNECT safebrowsing.google.com:443 - NONE/- text/html
1439958298.788      0 192.168.13.53 TCP_DENIED/403 1121 CONNECT alt1-safebrowsing.google.com:443 - NONE/- text/html
1439958337.674      0 192.168.13.53 TCP_DENIED/403 1121 CONNECT clients2.google.com:443 - NONE/- text/html
1439958358.808      0 192.168.13.53 TCP_DENIED/403 1121 CONNECT safebrowsing.google.com:443 - NONE/- text/html
1439958358.814      0 192.168.13.53 TCP_DENIED/403 1121 CONNECT alt1-safebrowsing.google.com:443 - NONE/- text/html
1439958459.546      0 192.168.13.53 TCP_DENIED/403 1121 CONNECT clients2.google.com:443 - NONE/- text/html
1439958514.979      0 192.168.13.53 TCP_DENIED/403 1121 CONNECT clients4.google.com:443 - NONE/- text/html
1439958580.179      0 192.168.13.53 TCP_DENIED/403 1121 CONNECT clients2.google.com:443 - NONE/- text/html
1439958703.591      1 192.168.13.53 TCP_DENIED/403 1121 CONNECT clients2.google.com:443 - NONE/- text/html
1439959171.753      1 192.168.13.53 TCP_DENIED/403 1121 CONNECT clients2.google.com:443 - NONE/- text/html
1439960144.286      0 192.168.13.53 TCP_DENIED/403 1121 CONNECT clients2.google.com:443 - NONE/- text/html
~~~~

### Custom 403
A custom 404 message has been added to `C:\squid\share\errors\English\ERR_ACCESS_DENIED`. Once this file was modified no additional configuration changes were required for this page to take effect.

### ERR_TUNNEL_CONNECTION_FAILED
When a HTTPS site is denied by Squid, because it attempts to return a 403 error with a different (or none) certificate, Google Chrome displays an `ERR_TUNNEL_CONNECTION_FAILED` error message rather than the nice 403 page. This appears to be a known issue around the intertubes with no known workarounds at this time:	

* [http://docs.diladele.com/faq/squid/cannot_connect_to_site_using_https.html](http://docs.diladele.com/faq/squid/cannot_connect_to_site_using_https.html)
* [http://wiki.squid-cache.org/Features/MimicSslServerCert](http://wiki.squid-cache.org/Features/MimicSslServerCert)
