Connect-AzAccount

#  Azure Web Apps Deployments
Get-AzSubscription 
Select-AzSubscription -Subscription "My Subscription"
$resourceGroupName = "RG-DEMO-NE"
$location = "North Europe"

# Create an Application Service Plan
$appSP= New-AzAppServicePlan -Name "SP-DEMO-PS" -Location $location -ResourceGroupName $resourceGroupName -Tier PremiumV2

# Create a Web Application                    
$webApp = New-AzWebApp -Name "wApp-DEMO-PS" -AppServicePlan $appSP.Name -ResourceGroupName $resourceGroupName -Location $location
Get-AzWebApp -ResourceGroupName $resourceGroupName -Name $webApp.Name | Select-Object Name,DefaultHostName,state,Location,ResourceGroup

             
# Create a deployment slot
$StagingSlotName = "Staging" 
New-AzWebAppSlot -Name $webApp.Name -ResourceGroupName $resourceGroupName -Slot $StagingSlotName

# Important: All the slots that are created in the same service plan, including the “Production” slot share resources. 
# For this reason, it is advisable to use an independent services plan in production environments.

# Clone an existing deployment slot
# Another way to create a new deployment slot is to clone an existing slot. 
# In the following example, I will create a new slot using the production slot as the source.

$productionSlotName = "Production" 
$productionSite = Get-AzWebAppSlot -Name $webApp.Name -ResourceGroupName $resourceGroupName -Slot $productionSlotName
New-AzWebAppSlot -Name $webApp.Name -ResourceGroupName $resourceGroupName -Slot $StagingSlotName -AppServicePlan $appSP.Name -SourceWebApp $productionSite
 
# Swap deployment slots
Swap-AzWebAppSlot -Name $webApp.Name -ResourceGroupName $resourceGroupName -SourceSlotName $StagingSlotName -DestinationSlotName $productionSlotName
 
# Remove a deployment slot
Remove-AzWebAppSlot -Name $webApp.Name -ResourceGroupName $resourceGroupName -Slot $StagingSlotName -Force

# Remove a Web Application
Remove-AzWebApp -Name $webApp.Name -ResourceGroupName $resourceGroupName -Force

# Remove an Application Service plan
Remove-AzAppServicePlan -Name "SP-DEMO-PS" -ResourceGroupName $resourceGroupName -Force
