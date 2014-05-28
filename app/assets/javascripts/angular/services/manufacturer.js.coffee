app.factory 'Manufacturer', ['$resource', ($resource) ->
  new class Manufacturer
    constructor: ->
      @service = $resource(
        '/api/manufacturers/:manufacturerId',
        {manufacturerId: '@id'}
      )
      @manufacturersCache = []

    index: ->
      @manufacturers = @service.query()

    get: (id) ->
      @service.query(manufacturerId: id)

    all: ->
      if @manufacturers? then @manufacturers else @index()

    show: (id) ->
      if @manufacturersCache[id]
        @manufacturersCache[id]
      else
        @manufacturersCache[id] = @get(id)
]
