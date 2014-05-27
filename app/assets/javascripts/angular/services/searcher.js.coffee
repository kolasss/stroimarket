app.factory 'Searcher', ['$resource', ($resource) ->
  new class Searcher
    constructor: ->
      @service = $resource(
        '/api/search/:query',
        {query: '@query'}
      )
      @searchCache = []

    get: (query) ->
      @service.get(query: query)

    show: (query) ->
      if @searchCache[query]
        @searchCache[query]
      else
        @searchCache[query] = @get(query)

]
