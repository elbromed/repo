
$Location="canadacentral"
$rsg="RG-HUB"

$parameterFile="D:\depot\repo\GumHUB02.parameters.json"
$templateFile = "D:\depot\repo\GumHUB02.template.json"
$Namedeployment="AzFwEnvironment"

New-AzResourceGroup -Name $rsg -Location $Location 
New-AzResourceGroupDeployment -Name $Namedeployment -ResourceGroupName $rsg -TemplateFile $templateFile -TemplateParameterFile $parameterFile -Verbose

#az group deployment validate --resource-group RG-HUB --template-file .\GumHUB02.template.json --parameters .\GumHUB02.parameters.json