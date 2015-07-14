angular.module 'App.campaigns', []
.controller 'CampaignsCtrl', ['campaigns'
  class CampaignsCtrl
    constructor: (@campaigns) ->
]
.controller 'CampaignShowCtrl', ['campaign', 'entries', 'user', '$modal'
  class CampaignShowCtrl
    constructor: (@campaign, @entries, @user, @$modal) ->
      @filter = {}

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
          nextEntry: => =>
            entries = _.filter @entries, status: 'unreviewed'
            if entries.length isnt 0
              index = entries.indexOf entry
              if index is -1
                entries[0]
              else
                entries[(index + 1) % entries.length]
            else
              return undefined

    filteredEntries: ->
      if @filter.status? and @filter.status isnt ''
        _.filter @entries, status: @filter.status
      else
        @entries

    acceptEntry: (entry) ->
      entry.status = 'accepted'

    rejectEntry: (entry) ->
      entry.status = 'rejected'
]
.controller 'CampaignEditCtrl', ['campaign', '$state'
  class CampaignEditCtrl
    constructor: (@campaign, @$state) ->

    saveCampaign: (campaign) ->
      campaign[if campaign.id then '$update' else '$save']()
      .then =>
        @$state.go 'main.campaigns'
]
.controller 'EntryDetailsCtrl', ['entry', 'nextEntry'
  class EntryDetailsCtrl
    constructor: (@entry, @nextEntry) ->

    acceptEntry: (entry, callback) ->
      entry.status = 'accepted'
      @goToNextEntry callback

    rejectEntry: (entry, callback) ->
      entry.status = 'rejected'
      @goToNextEntry callback

    goToNextEntry: (callback) ->
      entry = @nextEntry()
      if entry?
        @entry = entry
      else
        callback?()
]