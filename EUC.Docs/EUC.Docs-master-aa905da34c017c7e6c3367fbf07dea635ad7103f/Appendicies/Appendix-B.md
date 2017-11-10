## Appendix B - Admin Workstation Installation {#appendb}


~~~~ powershell
Add-AppvClientPackage -Path '\\m562prd1\src$\CM_Managed\Apps\Tier3\BCCDocGeneratorToolsBundle_1.0.0.0\Distribution\x86\REV02\BCC Doc Generator Tools Bundle 1.0.0.0.appv' -DynamicDeploymentConfiguration '\\m562prd1\src$\CM_Managed\Apps\Tier3\BCCDocGeneratorToolsBundle_1.0.0.0\Distribution\x86\REV02\BCC Doc Generator Tools Bundle 1.0.0.0_DeploymentConfig.xml' | Publish-AppvClientPackage -UserSID -DynamicUserConfigurationPath '\\m562prd1\src$\CM_Managed\Apps\Tier3\BCCDocGeneratorToolsBundle_1.0.0.0\Distribution\x86\REV02\BCC Doc Generator Tools Bundle 1.0.0.0_UserConfig.xml'
~~~~

