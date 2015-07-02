angular.module 'App.campaigns', []
.controller 'CampaignsCtrl', ['campaigns'
  class CampaignsCtrl
    constructor: (@campaigns) ->
]
.controller 'CampaignShowCtrl', ['campaign', 'entries', 'user'
  class CampaignShowCtrl
    constructor: (@campaign, @entries, @user) ->

    totalLikes: (entries) ->
      count = 0
      for e in entries
        count += e.likes.count
      count
]
.controller 'CampaignEditCtrl', ['campaign', '$state'
  class CampaignEditCtrl
    constructor: (@campaign, @$state) ->

    saveCampaign: (campaign) ->
      campaign[if campaign.id then '$update' else '$save']()
      .then =>
        @$state.go 'main.campaigns'
]
