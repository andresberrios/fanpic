angular.module 'App.common.masonry', []
.directive 'abMasonry', ['$timeout', ($timeout) ->
  restrict: 'A'
  scope: items: '&'
  link: (scope, element, attrs) ->
    scope.$watchCollection 'items()', (newCollection, oldCollection) ->
      $timeout ->
        imagesLoaded element, ->
          if element.data 'masonry'
            element.masonry 'destroy'
          element.masonry()
]
