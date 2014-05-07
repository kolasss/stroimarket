app.factory 'stroiUtils', ['$route', ($route) ->
  new class stroiUtils
    # constructor: ->
    #   @service = $resource(
    #     '/api/categories/:categoryId',
    #     {categoryId: '@id'}
    #   )

    # getCategoryLink: (category) ->
    #   return 'categories/' + category.slug if category

    # getServiceCategoryLink: (category) ->
    #   return 'service_categories/' + category.slug if category

    path_for: (controller, params, grill = true) ->
      prepend = if grill then '#' else ''
      for path of $route.routes
        pathController = $route.routes[path].controller
        if pathController == controller
          result = path
          for param of params
            result = prepend + result.replace(':' + param, params[param])
          return result

      return undefined
]
