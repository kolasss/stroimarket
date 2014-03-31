app.factory 'Category', ['$resource', ($resource) ->
  new class Category
    constructor: ->
      @service = $resource(
        '/api/categories/:categoryId',
        {categoryId: '@id'},
        {'get': {isArray:true}}
      )


    all: ->
      @service.query()

    show: (id) ->
      @service.get(categoryId: id)
]
