app.directive 'rangeSlider', ->
  return {
    restrict: 'A'
    scope:
      values: '='
      minValue: '='
      maxValue: '='
    link: (scope, elem, attrs) ->
      $(elem).slider
        range: true
        min: 0
        max: scope.values.length-1
        values: [0, scope.values.length-1]
        slide: (event, ui) ->
          scope.$apply ->
            scope.minValue = scope.values[ui.values[0]]
            scope.maxValue = scope.values[ui.values[1]]
          # console.log scope.minValue, scope.maxValue
  }
