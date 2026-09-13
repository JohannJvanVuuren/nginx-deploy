targetScope = 'resourceGroup'

param location string = 'southafricanorth'

@minLength(3)
@maxLength(24)
@description('StorageName must have min 3 chars and a max of 24 chars and can only contain lowercase letters and numbers')
param storageName string = 'storagespaceaa'

@description('This is the name prefix for the web application')
param namePrefix string = 'nginxDeploy'
param uniqueSuffix string = uniqueString(resourceGroup().id)

param dockerImage string = 'ubuntu/nginx'
param dockerImageTag string = 'latest'

// How to consume modules
module storage 'modules/storage.bicep' = {
  name: 'storage-module-${uniqueSuffix}'
  params: {
    location: location
    storageName: take('${storageName}${uniqueSuffix}', 24)
  }
}

module appPlanDeploy 'modules/servicePlan.bicep' = {
  name: '${namePrefix}-plan-module-${uniqueSuffix}'
  params: {
    namePrefix: '${namePrefix}-plan-module-${uniqueSuffix}'
    location: location
  }
}

module webappDeploy 'modules/webApp.bicep' = {
  name: '${namePrefix}-webapp-module-${uniqueSuffix}'
  params: {
    namePrefix: '${namePrefix}-webapp-module-${uniqueSuffix}'
    location: location
    appPlanId: appPlanDeploy.outputs.planId
    dockerImage: dockerImage
    dockerImageTag: dockerImageTag
  }
}

output siteUrl string = webappDeploy.outputs.siteUrl








// targetScope = 'resourceGroup'

// param location string = resourceGroup().location
// param name string = 'space'
// param storageName string = '${toLower(name)}${uniqueString(resourceGroup().id)}'

// resource storageaccount 'Microsoft.Storage/storageAccounts@2026-04-01' = {
//   name: storageName
//   location: location
//   kind: 'StorageV2'
//   sku: {
//     name: 'Standard_LRS'
//   }
//   properties: {
//     accessTier: 'Hot'
//   }
// }

// Creating a simple webpage
// resource appserviceplan 'Microsoft.Web/serverfarms@2025-03-01' = {
//   name: 'xyz${storageName}'
//   location: location
//   kind: 'linux'
//   sku: {
//     name: 'F1'
//     tier: 'Free'
//   }
// }

// resource webApplication 'Microsoft.Web/sites@2025-03-01' = {
//   name: 'zed${storageName}'
//   location: location
//   properties: {
//     serverFarmId: appserviceplan.id
//     httpsOnly: true
//   }
// }


// Data Types
// arrays, bool, int, object, string, secureString
// var nameArray = [
//   'johann'
//   'vanvuuren'
//   'tester'
//   3
//   0
// ]
// var person = {
//   name: 'Johann'
//   lastname: 'Van Vuuren'
//   age: 32
//   isMarried: false
//   education: {
//     university: 'Witwatersrand'
//     degree: 'BSc'
//     fieldOfStudy: 'Chemistry & Biochemistry'
//   }
// }
// output resultObject object = person
// output resultArray string = nameArray[0]

// Decorators
// @minLength(3)
// @maxLength(24)
// @description('')
// @allowed(['*&z', '_6b]) This list the only allowed options
// @metadata
// @secure // Secure data. Won't be logged or saved anywhere (E.g. passwords)
// @noStore
