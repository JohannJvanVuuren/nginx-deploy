param location string
param namePrefix string
param appPlanId string
param dockerImage string
param dockerImageTag string

resource webApplication 'Microsoft.Web/sites@2024-11-01' = {
  name: namePrefix
  location: location
  properties: {
    serverFarmId: appPlanId
    siteConfig: {
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVICE_URL'
          value: 'https://index.docker.io'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: 'johann'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: ''
        }
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE' 
          value: 'false'
        }
      ]
      linuxFxVersion: 'DOCKER|${dockerImage}:${dockerImageTag}'
    }
  }
}

output siteUrl string = webApplication.properties.hostNames[0]
