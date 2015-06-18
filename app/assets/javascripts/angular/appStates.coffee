angular.module 'App.states', []
.constant 'appStates',
  main:
    url: '/'
    abstract: yes
    controller: 'MainCtrl as ctrl'
    templateUrl: 'angular/main/mainTemplate.html'
  'main.login':
    url: 'login'
    controller: 'UserLoginCtrl'
  'main.default':
    url: ''
    controller: ['$state', ($state) -> $state.go 'main.homes', {}, location: 'replace']
  'main.homes':
    url: 'homes'
    controller: 'HomesCtrl as ctrl'
