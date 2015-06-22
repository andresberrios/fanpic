angular.module 'App.common.currentUser', []
.factory 'currentUser', ['Auth', '$q', (Auth, $q) ->
  (refetch) ->
    deferred = $q.defer()
    user =
      $promise: deferred.promise
      $resolved: no
    Auth[if refetch is yes then 'login' else 'currentUser']()
    .then (currentUser) ->
      user.$resolved = yes
      angular.extend user, currentUser
      deferred.resolve user
    user
]
