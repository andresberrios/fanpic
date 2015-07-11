angular.module 'App.users.signup', []
.controller 'UserSignUpCtrl', ['Auth', '$state'
  class UserSignUpCtrl
    constructor: (@Auth, @$state) ->
      @user = {}

    signUp: (user) ->
      @loading = yes
      @Auth.register
        email: user.email
        password: user.password
        password_confimation: user.password_confirmation
        name: user.name
      .then (registeredUser) =>
        @$state.go 'main.default'
      .catch (errors) =>
        if errors.data.email?
          @email_taken = true
      .finally =>
        @loading = no

]