param namePrefix string
param location string
param sku string = 'B1'

resource appServicePlan 'Microsoft.Web/serverfarms@2025-03-01' = {
  name: namePrefix
  location: location
  kind: 'linux'
  sku: {
    name: sku
  }
}

output planId string = appServicePlan.id
