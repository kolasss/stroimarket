app.factory 'stroiUtils', ['$route', ($route) ->
  new class stroiUtils
    # constructor: ->
    #   @service = $resource(
    #     '/api/categories/:categoryId',
    #     {categoryId: '@id'}
    #   )

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

    canEdit: (item_id) ->
      # console.log system_info
      return system_info.current_user.role == "admin" or system_info.current_user._id.$oid == item_id

    editProductPath: (product_id) ->
      path = system_info.routes.edit_product
      path.replace(/product_id/, product_id)

    editServicePath: (service_id) ->
      path = system_info.routes.edit_service
      path.replace(/service_id/, service_id)
]
