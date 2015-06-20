angular.module 'App', [
  'ngAnimate'
  'ngTouch'
  'ngResource'
  'ui.bootstrap'
  'Devise'
  'ui.router'

  'templates'
  'App.states'

  'App.main'
  'App.users'
]
.config [
  '$locationProvider', '$stateProvider', '$urlRouterProvider', 'appStates'
  ($locationProvider, $stateProvider, $urlRouterProvider, appStates) ->
    $locationProvider.html5Mode(yes).hashPrefix('!')
    for name, config of appStates
      $stateProvider.state name, config
    $urlRouterProvider.otherwise '/'
]
