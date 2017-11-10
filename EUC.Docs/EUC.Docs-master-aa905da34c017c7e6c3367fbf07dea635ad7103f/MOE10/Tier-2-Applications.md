## Tier 2 Applications

<div class="alert alert-warning" role="alert">
  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  This section is still under development
</div>

### Windows Store Apps

* currently we can only do *offline* apps from the Windows Store for Business
* look at the `Microsoft-Windows-AppXDeploymentServer/Operational` event log for errors
* [Troubleshooting packaging, deployment, and query of Windows Store apps](https://msdn.microsoft.com/en-us/library/windows/desktop/hh973484(v=vs.85).aspx)
* dependencies (for example .Net Framework) must reside under the root folder in a folder named `Dependencies`. **Dependencies can be picked up in other folders, but when it comes to being installed on the client, it will fail if they are not in this folder**
* I've had no luck deploying an application with an encoded license (.bin file). Maybe this is being blocked by IIS? Need to investigate when this is required
