app.controller 'CategoryCtrl',
  ['$scope', 'Category', '$routeParams', '$filter', 'Manufacturer', '$q', 'filterFilter',
  ($scope, Category, $routeParams, $filter, Manufacturer, $q, filterFilter) ->

    $scope.currentPage = 0
    $scope.pageSize = 10
    $scope.numberOfPages = 0

    $scope.currentCategory = {products: []}

    get_children_ids = (category) ->
      ids = []
      for subcat in category.children
        ids = ids.concat subcat.id
        if subcat.children.length > 0
          ids = ids.concat get_children_ids(subcat)
      return ids

    create_counters = ->
      $scope.manufacturers_counter = {}
      $scope.subcats_counter = {}

      for item in $scope.manufacturers
        $scope.manufacturers_counter[item.title] = 0

      for item in $scope.currentCategory.children
        $scope.subcats_counter[item.id] = 0
        item.children_ids = []
        if item.children.length > 0
          item.children_ids = get_children_ids(item)

    count_products = ->
      for item in $scope.currentCategory.products
        $scope.manufacturers_counter[item.manufacturer_title] += 1 if item.manufacturer_title

        if item.category_id.$oid != $scope.currentCategory.id
          if item.category_id.$oid of $scope.subcats_counter
            $scope.subcats_counter[item.category_id.$oid] += 1
          else
            for subcat in $scope.currentCategory.children
              if item.category_id.$oid in subcat.children_ids
                $scope.subcats_counter[subcat.id] += 1
                break

    $q.all([Category.all().$promise, Manufacturer.all().$promise]).then (results) ->
      $scope.currentCategory = $filter('getBySlug')(results[0], $routeParams.category_slug)

      $scope.manufacturers = $filter('manufacturerByCategory')(results[1], $scope.currentCategory)

      Category.show($scope.currentCategory.id).$promise.then (result) ->
        $scope.currentCategory.products = result

        # считаем товары по производителям и подкатегориям
        create_counters()

        count_products()


    # sorting
    $scope.sorting_by =
      min_price: 'цене'
      updated_at: 'новизне'
      views: 'популярности'

    $scope.sort = {
      column: null,
      descending: false
    };

    $scope.selectedCls = (column) ->
      if column == $scope.sort.column
        'active sort-' + $scope.sort.descending

    $scope.changeSorting = (column) ->
      sort = $scope.sort
      if sort.column == column
        sort.descending = !sort.descending
      else
        sort.column = column
        sort.descending = false

    #filtering
    $scope.filter =
      manufacturers: []
      subcats: []

    $scope.toggleBrand = (manufacturer) ->
      idx = $scope.filter.manufacturers.indexOf(manufacturer)
      if idx > -1
        $scope.filter.manufacturers.splice(idx, 1)
      else
        $scope.filter.manufacturers.push(manufacturer)

    $scope.toggleSubcat = (subcat_id, chidren_ids) ->
      ids = chidren_ids.concat subcat_id
      for id in ids
        idx = $scope.filter.subcats.indexOf(id)
        if idx > -1
          $scope.filter.subcats.splice(idx, 1)
        else
          $scope.filter.subcats.push(id)

    $scope.filteredProducts = () ->
      result = $scope.currentCategory.products
      filter = $scope.filter

      # string search
      result = filterFilter(result, filter.query) if filter.query

      # price range
      result = $filter('priceRangeCatalog')(result, filter)

      # by manufacturer
      result = $filter('productByManufacturer')(result, filter)

      # by subcategory
      result = $filter('productByCategory')(result, filter)

      $scope.numberOfPages = Math.ceil(result.length/$scope.pageSize) if result
      return result

]
