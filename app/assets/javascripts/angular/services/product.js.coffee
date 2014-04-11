app.factory 'Product', ['$resource', ($resource) ->
  new class Product
    constructor: ->
      @service = $resource(
        '/api/products/:productId',
        {productId: '@id'}
      )
      @productsCache = []

    get: (id) ->
      @service.get(productId: id)

    show: (id) ->
      if @productsCache[id]
        @productsCache[id]
      else
        @productsCache[id] = @get(id)
]
