targetScope = 'subscription'

param resourceGroupName string
param resourceGroupLocation string = 'norwayeast'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: resourceGroupName
}

module genvnet 'br/public:network/virtual-network:1.1.2' = {
  scope: rg
  name: 'Justasimplenetwork'
  params: {
    newOrExistingNSG: 'new'
    name: 'gen-0-virtual-network'
    location: resourceGroupLocation
    addressPrefixes: [
      '10.0.0.0/16'
    ]
    subnets: [
      {
        name: 'testsubnet'
        addressPrefix: '10.0.255.0/24'
      }
      {
        name: 'Subnet-for-testings'
        addressPrefix: '10.0.3.0/24'
        delegations: [
          {
            name: 'netappDel'
            properties: {
              serviceName: 'Microsoft.Netapp/volumes'
            }
          }
        ]
      }
    ]
  }
}
