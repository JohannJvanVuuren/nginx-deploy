param storageName string
param location string = 'southafricanorth'

resource storageaccount 'Microsoft.Storage/storageAccounts@2026-04-01' = {
  name: storageName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}
