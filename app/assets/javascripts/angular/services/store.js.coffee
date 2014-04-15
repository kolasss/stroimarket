app.factory 'Store', ['$resource', '$filter', ($resource, $filter) ->
  new class Store
    constructor: ->
      @service = $resource(
        '/api/stores/:storeId',
        {storeId: '@id'}
      )

    index: ->
      @stores = @service.query()

    show: (id) ->
      @service.query(storeId: id)

    all: ->
      if @stores? then @stores else @index()

    setCurrent: (store_slug) ->
      @current = $filter('getBySlug')(@stores, store_slug)

    getCurrent: (store_slug)->
      if store_slug?
        @setCurrent(store_slug)
      else
        @current
]
