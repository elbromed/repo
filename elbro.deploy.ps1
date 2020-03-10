
[CmdletBinding()]
Param
    (
        [Parameter(Mandatory=$true)]
        [ValidateSet('DEV','STG','PROD')]
        [string]$environment
        
    )
#write-Output $envirnt
#write-verbose $envirnt
$Location="canadacentral"
$envirntU=$environment.ToUpper()
$rsg=("RG-"+$envirntU)

if ($envirntU -eq "DEV") {
    $parameterFile="D:\git\repo\elbro.parameters.dev.json"
    $templateFile = "D:\git\repo\elbro.template.json"
    $Namedeployment="DevEnvironment"
}
if ($envirntU -eq "STG") {
    $parameterFile="D:\git\repo\elbro.parameters.stg.json"
    $templateFile = "D:\git\repo\elbro.template.json"
    $Namedeployment="StageEnvironment"
}
if ($envirntU -eq "PROD") {
    $parameterFile="D:\git\repo\elbro.parameters.prod.json"
    $templateFile = "D:\git\repo\elbro.template.json"
    $Namedeployment="ProdEnvironment"
}

New-AzResourceGroup -Name $rsg -Location $Location -VERBOSE
New-AzResourceGroupDeployment -Name $Namedeployment -ResourceGroupName $rsg -TemplateFile $templateFile -TemplateParameterFile $parameterFile -VERBOSE

#az group deployment validate --resource-group RG-PRD --template-file .\elbro.template.json --parameters .\elbro.parameters.stg.json