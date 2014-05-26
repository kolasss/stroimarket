app.directive 'navMenu',
  ['$route', 'Article',
  ($route, Article) ->
    return {
      restrict: 'A'
      link: (scope, element, attrs) ->

        scope.isActive = () ->
          if $route.current
            for argument in arguments
              return true if $route.current.controller == argument

        scope.isActiveArticle = (id) ->
          if $route.current and $route.current.controller == 'ArticleCtrl'
            article = Article.getCurrent()
            if article and article.$resolved
              if article._id.$oid == id
                return true
              else
                for parent in article.parent_ids
                  return true if parent.$oid == id

    }
]

app.directive 'categoriesDropdown',
  ['$route', 'Category',
  ($route, Category) ->
    return {
      restrict: 'A'
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
