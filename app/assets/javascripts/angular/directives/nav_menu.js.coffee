app.directive 'navMenu',
  ['$route',
  ($route) ->
    return {
      restrict: 'A'
      link: (scope, element, attrs) ->

        scope.getClass = () ->
          if $route.current
            for argument in arguments
              return 'active' if $route.current.controller == argument

    }
]
