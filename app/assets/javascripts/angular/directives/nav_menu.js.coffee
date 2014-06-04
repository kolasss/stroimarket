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
    # splitIntoRows = (array, columns) ->
    #   return [array] if array.length <= columns

    #   rowsNum = Math.ceil(array.length / columns)
    #   rowsArray = new Array(rowsNum)

    #   for i in rowsNum
    #     console.log i
    #     columnsArray = new Array(columns)
    #     for j in columns
    #       index = i * columns + j
    #       if index < array.length
    #         console.log array[index]
    #         columnsArray[j] = array[index]
    #       else
    #         break
    #     rowsArray[i] = columnsArray
    #   console.log rowsArray
    #   return rowsArray

    splitIntoColumns = (array, rows) ->
      return [array] if array.length <= rows

      columnsNum = Math.ceil(array.length / rows)
      finalArray = new Array(columnsNum)

      for i in [0...columnsNum]
        columnArray = new Array(rows)
        for j in [0...rows]
          index = i * rows + j
          if index < array.length
            columnArray[j] = array[index]
          else
            break
        finalArray[i] = columnArray
      return finalArray

    return {
      restrict: 'A'
      templateUrl: 'templates/navigation/categories.html'
      link: (scope, element, attrs) ->
        rows = 10

        Category.all().$promise.then (result) ->
          scope.categories = angular.copy(result)
          for cat in scope.categories
            cat.children = splitIntoColumns(cat.children, rows) if cat.children.length > 0

        scope.columnClass = (cat_length) ->
          "col-md-#{12 / cat_length}"
        scope.alwaysOpen = () ->
          if $route.current
            return 'always-opened' if $route.current.controller == 'HomeCtrl'
        scope.submenuClass = (category) ->
          'dropdown-submenu' if category.children.length > 0

    }
]
