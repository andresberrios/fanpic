angular.module 'App.models', []

.service 'Campaign', ['$resource', ($resource) ->
  $resource '/api/campaigns/:id.json', {id: '@id'},
    update: method: 'PUT'
    entries: method: 'GET', url: '/api/campaigns/:id/entries.json', isArray: yes
]
