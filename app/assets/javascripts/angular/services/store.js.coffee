app.factory 'Store', ['$resource', ($resource) ->
  new class Store
    constructor: ->
      @service = $resource(
        '/api/stores/:storeId',
        {storeId: '@id'}
      )
      @storesCache = []

    index: ->
      @stores = @service.query()

    get: (id) ->
      @service.query(storeId: id)

    all: ->
      if @stores? then @stores else @index()

    show: (id) ->
      if @storesCache[id]
        @storesCache[id]
      else
        @storesCache[id] = @get(id)
]
