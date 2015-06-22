
loadingTemplateDefault = """
<div class="text-center loading-layer">
  <i class="fa fa-refresh fa-spin fa-2x"></i>
</div>
"""
loadingTemplateOverlay = """
<div style="position:absolute;
            top:0;bottom:0;left:0;right:0;z-index:10;
            background-color:rgba(255,255,255,0.5)">
  <div class="text-center" style="
      position:absolute;left:0;right:0;top:50%;
      -webkit-transform:translateY(-50%);
      -moz-transform:translateY(-50%);
      -ms-transform:translateY(-50%);
      -o-transform:translateY(-50%);
      transform:translateY(-50%)">
    <i class="fa fa-refresh fa-spin fa-2x"></i>
  </div>
</div>
"""

overlayTemplate = """
<div style="position: fixed;
            top: 0; left: 0; bottom: 0; right: 0;
            z-index: 99999;">
</div>
"""

angular.module 'App.common.loading', []

.directive 'abLoading', [
  '$animate'
  '$compile'
  ($animate
   $compile) ->
    restrict: 'A'
    compile: (cElement, cAttrs) ->
      wrapper = angular.element '<div></div>'
      wrapper.append cElement.contents()
      cElement.append wrapper
      return (scope, element, attrs) ->
        template = loadingTemplateDefault
        if attrs.loadingStyle is 'overlay'
          positionStyle = element.css 'position'
          if positionStyle not in ['absolute', 'fixed']
            element.css 'position', 'relative'
          template = loadingTemplateOverlay

        stash = element.contents()
        loader = $compile(angular.element template) scope
        scope.$watch attrs.abLoading, (loading) ->
          if loading
            unless attrs.loadingStyle is 'overlay'
              $animate.addClass stash, 'ng-hide'
            $animate.enter loader, element
          else
            $animate.leave loader
            $animate.removeClass stash, 'ng-hide'
]

.factory 'loadingOverlay', [
  '$document', '$animate', '$compile', '$rootScope'
  ($document, $animate, $compile, $rootScope) ->
    overlay = angular.element overlayTemplate
    overlay.append angular.element loadingTemplateOverlay
    overlay = $compile(overlay) $rootScope
    body = $document.find 'body'
    return {
    show: ->
      $animate.enter overlay, body
    hide: ->
      $animate.leave overlay
    }
]
