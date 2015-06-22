angular.module 'App.campaigns', []
.controller 'CampaignsCtrl', ['campaigns'
  class CampaignsCtrl
    constructor: (@campaigns) ->
]
.controller 'CampaignShowCtrl', ['campaign'
  class CampaignShowCtrl
    constructor: (@campaign) ->
]
.controller 'CampaignEditCtrl', ['campaign', '$state'
  class CampaignEditCtrl
    constructor: (@campaign, @$state) ->

    saveCampaign: (campaign) ->
      campaign[if campaign.id then '$update' else '$save']()
      .then =>
        @$state.go 'main.campaigns'
]
