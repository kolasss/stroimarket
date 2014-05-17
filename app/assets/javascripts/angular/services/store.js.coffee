app.factory 'Store', ['$resource', '$filter', '$q', ($resource, $filter, $q) ->
  new class Store
    constructor: ->
      @service = $resource(
        '/api/stores/:storeId/:action',
        {storeId: '@id'}
      )
      @productsCache = []
      @popularsCache = []
      @newProductsCache = []
      @servicesCache = []

    index: ->
      @stores = @service.query()

    get: (id) ->
      @service.query(storeId: id)

    get_services: (id) ->
      @service.query
        storeId: id
        action: 'services'

    all: ->
      if @stores? then @stores else @index()

    products: (id) ->
      if @productsCache[id]
        @productsCache[id]
      else
        @productsCache[id] = @get(id)

    popular: (id) ->
      if @popularsCache[id]
        @popularsCache[id]
      else
        deferred=$q.defer()
        @products(id).$promise.then (result) =>
          deferred.resolve($filter('orderBy')(result, '-views')[0..10])
        return @popularsCache[id] = deferred.promise

    new_products: (id) ->
      if @newProductsCache[id]
        @newProductsCache[id]
      else
        deferred=$q.defer()
        @products(id).$promise.then (result) =>
          deferred.resolve($filter('orderBy')(result, '-updated_at')[0..10])
        return @newProductsCache[id] = deferred.promise

    services: (id) ->
      if @servicesCache[id]
        @servicesCache[id]
      else
        @servicesCache[id] = @get_services(id)
]
