app.factory 'Category', ['$resource', '$filter', ($resource, $filter) ->
  new class Category
    constructor: ->
      @service = $resource(
        '/api/categories/:categoryId',
        {categoryId: '@id'}
      )

    index: ->
      @categories = @service.query()

    show: (id) ->
      @service.query(categoryId: id)

    all: ->
      if @categories? then @categories else @index()

    setCurrent: (category_slug) ->
      @current = $filter('getBySlug')(@categories, category_slug)

    getCurrent: (category_slug)->
      if category_slug?
        @setCurrent(category_slug)
      else
        @current
]
