angular.module 'App.models', []

.service 'Campaign', ['$resource', ($resource) ->
  $resource '/api/v1/campaigns/:id.json', {id: '@id'},
    update: method: 'PUT'
    entries: method: 'GET', url: '/api/campaigns/:id/entries.json', isArray: yes
]

.service 'Entry', ['$resource', ($resource) ->
  $resource '/api/v1/campaigns/:campaignId/entries/:id.json',
    {campaignId: '@campaign_id', id: '@id'},
    update: method: 'PUT'
    entries: method: 'GET', url: '/api/campaigns/:id/entries.json', isArray: yes
]
