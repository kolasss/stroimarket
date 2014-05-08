app.factory 'Post', ['$resource', ($resource) ->
  new class Post
    constructor: ->
      @service = $resource(
        '/api/posts/:postId',
        {postId: '@id'}
      )
      # @postsCache = []

    index: ->
      @posts = @service.query()

    # get: (id) ->
    #   @service.query(postId: id)

    all: ->
      if @posts? then @posts else @index()

    # show: (id) ->
    #   if @postsCache[id]
    #     @postsCache[id]
    #   else
    #     @postsCache[id] = @get(id)

]
