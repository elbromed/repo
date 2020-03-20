
$Location="canadacentral"
$rsg="Gum-rg-devops"

$parameterFile="D:\depot\repo\Gum-devops02.parameters.json"
$templateFile = "D:\depot\repo\Gum-devops02.template.json"
$Namedeployment="Gum-rg-devops-deployment-test"

#New-AzResourceGroup -Name $rsg -Location $Location 
New-AzResourceGroupDeployment -Name $Namedeployment -ResourceGroupName $rsg -TemplateFile $templateFile -TemplateParameterFile $parameterFile -Verbose

#az group deployment validate --resource-group gumsite-rg-devops --template-file .\Gum-devops01.template.json --parameters .\Gum-devops01.parameters.json