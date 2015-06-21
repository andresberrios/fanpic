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
    controller: ['$state', ($state) -> $state.go 'main.campaigns', {}, location: 'replace']
  'main.campaigns':
    url: '/campaigns'
    controller: 'CampaignsCtrl as ctrl'
    templateUrl: 'angular/campaigns/campaignsTemplate.html'
    resolve:
      campaigns: ['Campaign', (Campaign) -> Campaign.query()]
  'main.editCampaign':
    url: '/campaigns/:campaignId'
    controller: 'CampaignEditCtrl as ctrl'
    templateUrl: 'angular/campaigns/campaignEditTemplate.html'
    resolve:
      campaign: ['Campaign', '$stateParams', (Campaign, $stateParams) ->
        if $stateParams.campaignId is 'new'
          new Campaign()
        else
          Campaign.get $stateParams.campaignId
      ]
