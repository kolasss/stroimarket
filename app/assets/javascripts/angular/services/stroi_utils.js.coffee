app.factory 'stroiUtils', ->
  new class stroiUtils
    # constructor: ->
    #   @service = $resource(
    #     '/api/categories/:categoryId',
    #     {categoryId: '@id'}
    #   )

    getCategoryLink: (category) ->
      return 'categories/' + category.slug if category
