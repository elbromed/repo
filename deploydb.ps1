
$Location="canadacentral"
$rsg="test-db"

$parameterFile="D:\depot\repo\test-db.parameters.json"
$templateFile = "D:\depot\repo\test-db.template.json"
$Namedeployment="AzFwEnvironment"

New-AzResourceGroup -Name $rsg -Location $Location 
New-AzResourceGroupDeployment -Name $Namedeployment -ResourceGroupName $rsg -TemplateFile $templateFile -TemplateParameterFile $parameterFile -Verbose

#az group deployment validate --resource-group RG-HUB --template-file .\GumHUB01.template.json --parameters .\GumHUB01.parameters.json