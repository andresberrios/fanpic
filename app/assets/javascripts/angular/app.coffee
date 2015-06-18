angular.module 'App', [
  'ngAnimate'
  'ngTouch'
  'ngResource'
  'ui.bootstrap'
  'Devise'
  'ui.router'

  'templates'
]
.config [
  '$stateProvider', '$urlRouterProvider', 'appStates'
  ($stateProvider, $urlRouterProvider, appStates) ->
    for name, config of appStates
      $stateProvider.state name, config
    $urlRouterProvider.otherwise '/'
]
