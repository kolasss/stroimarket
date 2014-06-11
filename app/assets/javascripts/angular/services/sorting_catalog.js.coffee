app.factory 'SortingCatalog', ->
  new class SortingCatalog
    constructor: ->
      @sorting_by =
        min_price: 'цене'
        updated_at: 'новизне'
        views: 'популярности'
      @sorting_by2 =
        price: 'цене'
        updated_at: 'новизне'
        views: 'популярности'
      @sort =
        column: null
        descending: false
      @pageSize = 10

    selectedCls: (column) ->
      if column == @sort.column
        'active sort-' + @sort.descending

    changeSorting: (column) ->
      if @sort.column == column
        @sort.descending = !@sort.descending
      else
        @sort.column = column
        @sort.descending = if column == 'min_price' or column == 'price' then false else true
