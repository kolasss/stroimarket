app.factory 'ServiceCategory', ['$resource', ($resource) ->
  new class ServiceCategory
    constructor: ->
      @service = $resource(
        '/api/service_categories/:categoryId',
        {categoryId: '@id'}
      )

    index: ->
      @categories = @service.query()

    all: ->
      if @categories? then @categories else @index()

]
