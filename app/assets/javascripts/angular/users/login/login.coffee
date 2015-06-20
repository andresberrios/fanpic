
angular.module 'App.users.login', []
.controller 'UserLoginCtrl', ['Auth', '$location'
  class UserLoginCtrl
    constructor: (Auth, $location) ->
      Auth.currentUser().then ->
        $location.url '/'
]
.controller 'UserLoginModalCtrl', ['Auth'
  class UserLoginModalCtrl
    constructor: (@Auth) ->

    login: (email, password, $close) ->
      @loading = yes
      @Auth.login
        email: email
        password: password
      .then $close
      .catch (error) =>
        @error = error.data.error ? yes
      .finally =>
        @loading = no
]
.factory 'loginModal', ['$modal', ($modal) ->
  openModal = null
  open: ->
    unless openModal
      openModal = $modal.open
        templateUrl: 'angular/users/login/loginModalTemplate.html'
        backdrop: 'static'
        keyboard: no
        controller: 'UserLoginModalCtrl as ctrl'
      .result.then -> openModal = null
    openModal
]
.config ['AuthInterceptProvider', (AuthInterceptProvider) ->
  AuthInterceptProvider.interceptAuth yes
]
.run ['$rootScope', '$http', 'loginModal', ($rootScope, $http, loginModal) ->
  $rootScope.$on 'devise:unauthorized', (event, originalResponse, deferred) ->
    if originalResponse.config.url is '/users/sign_in.json' and
      originalResponse.config.data.user.email and originalResponse.config.data.user.password
        deferred.reject originalResponse
    else
      loginModal.open().then ->
        $http originalResponse.config
      .then (response) ->
        deferred.resolve response
      .catch (error) ->
        deferred.reject error
]
