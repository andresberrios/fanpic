angular.module 'App.main', []
.controller 'MainCtrl', ['Auth', '$state', '$scope'
  class MainCtrl
    constructor: (@Auth, $state, $scope) ->
      @Auth.currentUser().then (user) =>
        @currentUser = user
      $scope.$on 'devise:login', (event, user) =>
        @currentUser = user
      $scope.$on 'devise:logout', (event, oldUser) =>
        delete @currentUser
        $state.go 'main.login'
]
