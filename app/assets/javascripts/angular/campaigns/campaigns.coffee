angular.module 'App.campaigns', []
.controller 'CampaignsCtrl', ['campaigns'
  class CampaignsCtrl
    constructor: (@campaigns) ->
]
.controller 'CampaignShowCtrl', ['campaign', 'entries', 'user', '$modal'
  class CampaignShowCtrl
    constructor: (@campaign, @entries, @user, @$modal) ->

    totalLikes: (entries) ->
      count = 0
      for e in entries
        count += e.likes.count
      count

    showEntryDetails: (entry) ->
      @$modal.open
        templateUrl: 'angular/campaigns/entryDetailsTemplate.html'
        controller: 'EntryDetailsCtrl as ctrl'
        size: 'lg'
        resolve:
          entry: -> entry
]
.controller 'CampaignEditCtrl', ['campaign', '$state'
  class CampaignEditCtrl
    constructor: (@campaign, @$state) ->

    saveCampaign: (campaign) ->
      campaign[if campaign.id then '$update' else '$save']()
      .then =>
        @$state.go 'main.campaigns'
]
.controller 'EntryDetailsCtrl', ['entry'
  class EntryDetailsCtrl
    constructor: (@entry) ->
]