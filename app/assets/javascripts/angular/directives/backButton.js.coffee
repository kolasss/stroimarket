app.directive 'backButton', ->
  return {
    restrict: 'A'

    link: (scope, element, attrs) ->
      goBack = ->
        history.back()
        scope.$apply()

      element.bind('click', goBack)
  }
