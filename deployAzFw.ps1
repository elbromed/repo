
$Location="canadacentral"
$rsg="RG-HUB"

$parameterFile="D:\git\repo\GumHUB01.parameters.json"
$templateFile = "D:\git\repo\GumHUB01.template.json"
$Namedeployment="AzFwEnvironment"

New-AzResourceGroup -Name $rsg -Location $Location 
New-AzResourceGroupDeployment -Name $Namedeployment -ResourceGroupName $rsg -TemplateFile $templateFile -TemplateParameterFile $parameterFile -Verbose

#az group deployment validate --resource-group RG-HUB --template-file .\GumHUB01.parameters.json --parameters .\GumHUB01.template.json