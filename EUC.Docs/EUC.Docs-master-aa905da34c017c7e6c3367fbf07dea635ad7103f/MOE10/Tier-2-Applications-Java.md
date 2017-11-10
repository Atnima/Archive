
### Java Runtimes

| App | JRE Version  | URL |
|---|---|---|---|---|
| RIMS iEdition  | 1.4.2_05  |  https://mw-apps.lb.bcc.qld.gov.au/rimscld/iedition |
| RIMS iEdition UAT | 1.4.2_05  |  https://mw-apps-uat.lb.bcc.qld.gov.au/rimscld/iedition |
|  ICCS | 1.4.2_06  |  https://mw-bi.lb.bcc.qld.gov.au/forms/frmservlet?config=iccs |
| ICCS UAT | 1.4.2_06  |  https://mw-bi-uat.lb.bcc.qld.gov.au/forms/frmservlet?config=iccs |
| CoreLand  | 1.4.2_17  | https://mw-bi.lb.bcc.qld.gov.au/forms/frmservlet?config=clnd  |
| CoreLand UAT | 1.4.2_17  |  https://mw-bi-uat.lb.bcc.qld.gov.au/forms/frmservlet?config=clnd |
| Discoverer  | 1.6.0_31  | https://mw-bi.lb.bcc.qld.gov.au/discoverer/plus?db=DART_DISCO&eul=LT_EUL |
| Discoverer UAT | 1.6.0_31  | https://mw-bi-uat.lb.bcc.qld.gov.au/discoverer/plus?db=DART_DISCO_UAT&eul=LT_EUL |
| DART  | 1.7.0_55  | http://intranet.bcc.qld.gov.au/ict/onlinesystems/DART/Pages/default.aspx  |
| NextBus | 1.8.0_73 | N/A |


#### group policy
https://blogs.msdn.microsoft.com/ie/2014/08/06/internet-explorer-begins-blocking-out-of-date-activex-controls/

configured for ad.bcc.qld.gov.au and bcc.qld.gov.au


#### deployment.properties

http://docs.oracle.com/javase/1.5.0/docs/guide/deployment/deployment-guide/properties.html
http://docs.oracle.com/javase/6/docs/technotes/guides/deployment/deployment-guide/properties.html
https://docs.oracle.com/javase/7/docs/technotes/guides/jweb/jcp/properties.html
https://docs.oracle.com/javase/8/docs/technotes/guides/deploy/properties.html

#### 1.7.0_40 and above

Deployment Rule Sets
https://blogs.oracle.com/java-platform-group/entry/introducing_deployment_rule_sets

#### App-V Checklist


~~~~
[ ] packaged as add-on or plug-in
[ ] don't need to open IE - just install
[ ] used -noframemerging for IE shortcut
C:\Program Files (x86)\Internet Explorer\iexplore.exe -noframemerging https://mw-bi-uat.lb.bcc.qld.gov.au/discoverer/plus?db=DART_DISCO_UAT&eul=LT_EUL

C:\Program Files (x86)\Internet Explorer\iexplore.exe -noframemerging https://mw-bi.lb.bcc.qld.gov.au/forms/frmservlet?config=iccs

[ ] specifically added %APPDATA%\Sun as an override folder
[ ] specifically added %LOCALLOWAPPDATA%\Sun as an override folder    as an override folder for Java 1.4.2_17 and higher
[ ] updated icons for shortcuts
[ ] shortcuts should live under 'Start Menu' under folder named 'Online Systems'

Online Systems\Non-production
~~~~
