app.factory 'Product', ['$resource', ($resource) ->
  new class Product
    constructor: ->
      @service = $resource(
        '/api/products/:productId',
        {
          productId: '@id'
        }, {
          popular:
            method: 'GET'
            params:
              productId: 'popular'
            isArray: true
        }
      )
      @productsCache = []

    get: (id) ->
      @service.get(productId: id)

    show: (id) ->
      if @productsCache[id]
        @productsCache[id]
      else
        @productsCache[id] = @get(id)

    getPopular: ->
      @popularCache = @service.popular()

    popular: ->
      if @popularCache? then @popularCache else @getPopular()
]
