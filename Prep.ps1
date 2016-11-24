
Set-Location -Path '~\OneDrive\Documents\Get-PSUGUK Lability';
Remove-LabConfiguration -ConfigurationData .\Get-PSUGUKv3.psd1 -Verbose;
Remove-Item -Path "$((Get-LabHostDefault).ParentVhdPath)\2016_x64_Datacenter_Nano_EN_Eval.vhdx" -Force -ErrorAction SilentlyContinue;
Remove-Item -Path "$((Get-LabHostDefault).ConfigurationPath)\getpsuguk*.mof" -ErrorAction SilentlyContinue;
