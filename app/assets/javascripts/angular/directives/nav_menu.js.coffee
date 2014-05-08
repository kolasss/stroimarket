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

app.directive 'categoriesDropdown',
  ['$route', 'Category',
  ($route, Category) ->
    return {
      restrict: 'A'
      # replace: true
      # scope:
        # categoriesData: '='
        # onSelect: '&'
        # maxLevel: '@'
        # onMain: '@'
        # type: '@'
      templateUrl: 'templates/navigation/categories.html'
      link: (scope, element, attrs) ->
        scope.categories = Category.all()

        scope.alwaysOpen = () ->
          if $route.current
            return 'always-opened' if $route.current.controller == 'HomeCtrl'
        scope.submenuClass = (category) ->
          'dropdown-submenu' if category.children.length > 0

    }
]
