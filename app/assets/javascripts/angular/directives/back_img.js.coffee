app.directive 'backImg', ->
  return {
    restrict: 'A'
    link: (scope, element, attrs) ->
      attrs.$observe 'backImg', (value)->
        element.css
          'background-image': "url(#{value})"
  }
