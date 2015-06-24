angular.module 'App', [
  'ngAnimate'
  'ngTouch'
  'ngResource'
  'ui.bootstrap'
  'Devise'
  'ui.router'

  'templates'
  'App.states'
  'App.models'
  'App.common'

  'App.main'
  'App.users'
  'App.campaigns'
]
.config [
  '$locationProvider', '$stateProvider', '$urlRouterProvider', 'appStates'
  ($locationProvider, $stateProvider, $urlRouterProvider, appStates) ->
    $locationProvider.html5Mode(yes).hashPrefix '!'
    for name, config of appStates
      $stateProvider.state name, config
    $urlRouterProvider.otherwise '/not-found'
]
.run -> Array::pull = (item) -> _.pull @, item
