param location string
param loadbalancername string
param backendadresspoolname string
param ipaddresswindowsvm string
param loadbalancerfrontendipaddress string
param loadbalancerfrontendipaddressid string
param subnetvmid string
param virtualnetworkid string
param location string
param nameofpublicipadress

resource symbolicname 'Microsoft.Network/loadBalancers@2022-07-01' = {
  name: loadbalancername
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    backendAddressPools: [
      {
        name: 'virtualmachinesbackendpool'
        properties: {
          loadBalancerBackendAddresses: [
            {
              name: backendadresspoolname
              properties: {
                ipAddress: ipaddresswindowsvm
                loadBalancerFrontendIPConfiguration: {
                  id: publicIPAddress
                }
                subnet: {
                  id: subnetvmid
                }
                virtualNetwork: {
                  id: virtualnetworkid
                }
              }
            }
          ]
          location: location
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'loadbalancerpublicip'
        properties: {
          gatewayLoadBalancer: {
            id: 'string'
          }
          publicIPAddress: {
            location: location
            properties: {
              deleteOption: 'delete'
              publicIPAddressVersion: 'IPv4'
              publicIPAllocationMethod: 'Dynamic'
            }
            sku: {
              name: 'publicipaddresssku'
              tier: 'Regional'
            }
          }
        }
      }
    ]
    loadBalancingRules: [
      {
        name: 'traffictovm'
        properties: {
          backendAddressPool: {
            id: 'string'
          }
          backendAddressPools: [
            {
              id: backendadresspoolname.id
            }
          ]
          backendPort: 3389
          disableOutboundSnat: false
          enableFloatingIP: true
          enableTcpReset: bool
          frontendIPConfiguration: {
            id: 'string'
          }
          frontendPort: 3389
          idleTimeoutInMinutes: int
          loadDistribution: 'string'
          probe: {
            id: 'string'
          }
          protocol: 'string'
        }
      }
    ]
    outboundRules: [
      {
        id: 'string'
        name: 'string'
        properties: {
          allocatedOutboundPorts: int
          backendAddressPool: {
            id: 'string'
          }
          enableTcpReset: bool
          frontendIPConfigurations: [
            {
              id: 'string'
            }
          ]
          idleTimeoutInMinutes: int
          protocol: 'string'
        }
      }
    ]
    probes: [
      {
        id: 'string'
        name: 'string'
        properties: {
          intervalInSeconds: int
          numberOfProbes: int
          port: int
          probeThreshold: int
          protocol: 'string'
          requestPath: 'string'
        }
      }
    ]
  }
}
