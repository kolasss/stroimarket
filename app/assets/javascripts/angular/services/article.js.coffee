app.factory 'Article', ['$resource', ($resource) ->
  new class Article
    constructor: ->
      @service = $resource(
        '/api/articles/:articleId',
        {articleId: '@id'}
      )
      @articlesCache = []

    index: ->
      @articles = @service.query()

    get: (id) ->
      @service.get(articleId: id)

    all: ->
      if @articles? then @articles else @index()

    show: (id) ->
      if @articlesCache[id]
        @articlesCache[id]
      else
        @articlesCache[id] = @get(id)

]
