app.factory 'Service', ['$resource', ($resource) ->
  new class Service
    constructor: ->
      @service = $resource(
        '/api/services/:serviceId',
        {serviceId: '@id'}
      )
      @servicesCache = []

    get: (id) ->
      @service.get(serviceId: id)

    show: (id) ->
      if @servicesCache[id]
        @servicesCache[id]
      else
        @servicesCache[id] = @get(id)
]
