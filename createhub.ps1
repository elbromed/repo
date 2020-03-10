$Location="canadacentral"
$RG="RG-HUB"

write-host "Create Resource Group"
New-AzResourceGroup -Name $RG -Location $Location

# Virtual network
# Create the virtual network RG-HUB.
write-host "Create Network HUB"
$FWsub = New-AzVirtualNetworkSubnetConfig -Name AzureFirewallSubnet -AddressPrefix 192.168.1.0/26
$CORPsub = New-AzVirtualNetworkSubnetConfig -Name CorpSubnet -AddressPrefix 192.168.10.0/24
$INFRAsub = New-AzVirtualNetworkSubnetConfig -Name InfraSubnet -AddressPrefix 192.168.20.0/24
$AGsub = New-AzVirtualNetworkSubnetConfig -Name AGSubnet -AddressPrefix 192.168.50.0/24
#$BackendAGsub = New-AzVirtualNetworkSubnetConfig -Name BackendAGSubnet -AddressPrefix 192.168.60.0/24
$VPNsub = New-AzVirtualNetworkSubnetConfig -Name VPNSubnet -AddressPrefix 192.168.70.0/24
$VNetHUB = New-AzVirtualNetwork -Name VNet-HUB -ResourceGroupName $RG -Location $Location -AddressPrefix 192.168.0.0/16 -Subnet $FWsub, $CORPsub, $AGsub, $VPNsub, $INFRAsub

write-host "Create VM HUB"
# Get the subnet object for use in a later step.
$Subnet = Get-AzVirtualNetworkSubnetConfig -Name $CorpSub.Name -VirtualNetwork $VNetHUB
$IpConfigName1 = "IPConfig-1"
$IpConfig1     = New-AzNetworkInterfaceIpConfig -Name $IpConfigName1 -Subnet $Subnet -PrivateIpAddress 192.168.10.50 -Primary
$NIC = New-AzNetworkInterface -Name MyNIC -ResourceGroupName RG-HUB -Location $Location -IpConfiguration $IpConfig1

#Create the NIC
##$VNetHUB
##$NIC = New-AzNetworkInterface -Name ip-VM01 -ResourceGroupName RG-HUB -Location $Location  -Subnetid $VNetHUB.Subnets[1].Id 

#Define the virtual machine
$VirtualMachine = New-AzVMConfig -VMName VMCorp01 -VMSize Standard_D3_v2
$VirtualMachine = Set-AzVMOperatingSystem -VM $VirtualMachine -Windows -ComputerName VMCorp01 -ProvisionVMAgent -EnableAutoUpdate
$VirtualMachine = Add-AzVMNetworkInterface -VM $VirtualMachine -Id $NIC.Id
$VirtualMachine = Set-AzVMSourceImage -VM $VirtualMachine -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowsServer' -Skus '2016-Datacenter' -Version latest

#Create the virtual machine
New-AzVM -ResourceGroupName RG-HUB -Location $Location -VM $VirtualMachine -Verbose