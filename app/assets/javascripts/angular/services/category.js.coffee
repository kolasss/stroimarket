app.factory 'Category', ['$resource', ($resource) ->
  new class Category
    constructor: ->
      @service = $resource(
        '/api/categories/:categoryId',
        {categoryId: '@id'}
      )
      @categoriesCache = []

    index: ->
      @categories = @service.query()

      @categories.$promise.then (result) =>
        for item in @categories
          @set_children_ids(item)

      return @categories

    get: (id) ->
      @service.query(categoryId: id)

    all: ->
      if @categories? then @categories else @index()

    show: (id) ->
      if @categoriesCache[id]
        @categoriesCache[id]
      else
        @categoriesCache[id] = @get(id)

    set_children_ids: (category) ->
      ids = []
      for subcat in category.children
        ids = ids.concat subcat.id
        # if subcat.children_ids and subcat.children_ids.length > 0
        #   console.log subcat.children_ids
        #   ids = ids.concat subcat.children_ids
        if subcat.children.length > 0
          ids = ids.concat @set_children_ids(subcat)
      category.children_ids = ids
      return ids
]
