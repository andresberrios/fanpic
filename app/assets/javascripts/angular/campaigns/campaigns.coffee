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

    showEntryDetails: (entry, requirements, rejecting = no) ->
      @$modal.open
        templateUrl: 'angular/campaigns/entryDetailsTemplate.html'
        controller: 'EntryDetailsCtrl as ctrl'
        size: 'lg'
        resolve:
          entry: -> entry
          requirements: -> requirements
          rejecting: -> rejecting
          nextEntry: => (entry) =>
            if @entries.length isnt 0
              index = @entries.indexOf entry
              if index is -1
                @entries[0]
              else
                @entries[(index + 1) % @entries.length]
            else
              return undefined

    filteredEntries: ->
      if @filter.status? and @filter.status isnt ''
        _.filter @entries, status: @filter.status
      else
        @entries

    evaluateEntry: (entry, status) ->
      entry.status = status
      if entry.status is 'rejected'
        @showEntryDetails entry, @campaign.requirements, yes
      else
        entry[if entry.id? then '$update' else '$save']()
]
.controller 'CampaignEditCtrl', ['campaign', '$state'
  class CampaignEditCtrl
    constructor: (@campaign, @$state) ->

    saveCampaign: (campaign) ->
      campaign[if campaign.id then '$update' else '$save']()
      .then =>
        @$state.go 'main.campaigns'
]
.controller 'EntryDetailsCtrl', ['entry', 'requirements', 'rejecting', 'nextEntry'
  class EntryDetailsCtrl
    constructor: (@entry, @requirements, @rejecting, @nextEntry) ->
      @requirementsHash = {}
      for requirement in @requirements
        @requirementsHash[requirement] = no

    evaluateEntry: (entry, status, callback) ->
      if status is 'rejected'
        @rejecting = yes
      else
        entry.status = status
        entry[if entry.id? then '$update' else '$save']().then =>
          @goToNextEntry entry, callback

    cancelRejection: ->
      @cleanRequirementsHash()
      @rejecting = no

    rejectEntry: (entry, callback) ->
      entry.status = 'rejected'
      entry.unmet_requirements = (req for req, active of @requirementsHash when active)
      entry[if entry.id? then '$update' else '$save']().then =>
        @goToNextEntry entry, callback

    goToNextEntry: (entry, callback) ->
      entry = @nextEntry entry
      if entry?
        @cleanRequirementsHash()
        @rejecting = no
        @entry = entry
      else
        callback?()

    selectReason: (requirement, active) ->
      @requirementsHash[requirement] = not active

    checkReasonSelected: ->
      checked = no
      for own requirement, active of @requirementsHash
        if active
          checked = yes
      !checked

    cleanRequirementsHash: ->
      for own requirement, active of @requirementsHash
        @requirementsHash[requirement] = no
]