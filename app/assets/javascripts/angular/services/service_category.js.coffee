app.factory 'ServiceCategory', ['$resource', ($resource) ->
  new class ServiceCategory
    constructor: ->
      @service = $resource(
        '/api/service_categories/:categoryId',
        {categoryId: '@id'}
      )
      @serviceCategoriesCache = []

    index: ->
      @categories = @service.query()

    get: (id) ->
      @service.query(categoryId: id)

    all: ->
      if @categories? then @categories else @index()

    show: (id) ->
      if @serviceCategoriesCache[id]
        @serviceCategoriesCache[id]
      else
        @serviceCategoriesCache[id] = @get(id)
]
