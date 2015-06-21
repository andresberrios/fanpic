angular.module 'App.states', []
.constant 'appStates',
  main:
    url: '/panel'
    abstract: yes
    controller: 'MainCtrl as ctrl'
    templateUrl: 'angular/main/mainTemplate.html'
  'main.login':
    url: '/login'
    controller: 'UserLoginCtrl'
  'main.default':
    url: ''
    controller: ['$state', ($state) -> $state.go 'main.login', {}, location: 'replace']
  'main.campaigns':
    url: '/campaigns'
    controller: 'CampaignsCtrl as ctrl'
    templateUrl: 'angular/campaigns/campaignsTemplate.html'
