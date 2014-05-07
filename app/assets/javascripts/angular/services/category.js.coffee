app.factory 'Category', ['$resource', ($resource) ->
  new class Category
    constructor: ->
      @service = $resource(
        '/api/categories/:categoryId',
        {categoryId: '@id'}
      )
      @categoriesCache = []

    index: ->
      @categories = @service.query()

    get: (id) ->
      @service.query(categoryId: id)

    all: ->
      if @categories? then @categories else @index()

    show: (id) ->
      if @categoriesCache[id]
        @categoriesCache[id]
      else
        @categoriesCache[id] = @get(id)

]
