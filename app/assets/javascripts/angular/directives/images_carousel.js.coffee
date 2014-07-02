app.directive 'imagesCarousel',
  ['$timeout',
  ($timeout) ->
    return {
      restrict: 'A'
      link: (scope, element, attrs) ->
        scope.$on 'onRepeatLast', ->
          # console.log 'ok'
          $timeout ->
            element.carouFredSel
              width: '100%'
              transition: true
              scroll:
                pauseOnHover: true
              swipe:
                onMouse: true
                onTouch: true
    }
]

app.directive 'onLastRepeat', ->
  return (scope, element, attrs) ->
    scope.$emit('onRepeatLast') if scope.$last
