angular.module 'App.common.masonry', []
.directive 'abMasonry', ['$timeout', ($timeout) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    $timeout ->
      imgLoad = imagesLoaded element
      imgLoad.on 'always', ->
        element.children().css 'margin-bottom': '10px'
        element.masonry gutter: 10
    , 1000
]