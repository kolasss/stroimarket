app.controller 'StoreMainCtrl',
  ['$scope', 'Store', '$routeParams', '$filter', 'Category', '$q', 'filterFilter', 'SortingCatalog',
  ($scope, Store, $routeParams, $filter, Category, $q, filterFilter, SortingCatalog) ->

    $scope.SortingCatalog = SortingCatalog
    $scope.currentPage = 0
    $scope.numberOfPages = 0

    $scope.currentStore = {products: []}

    #counters
    get_children_ids = (category) ->
      ids = []
      for subcat in category.children
        ids = ids.concat subcat.id
        if subcat.children.length > 0
          ids = ids.concat get_children_ids(subcat)
      return ids

    create_counters = ->
      $scope.cats_counter = {}

      for item in $scope.categories
        $scope.cats_counter[item.id] = 0
        item.children_ids = []
        if item.children.length > 0
          item.children_ids = get_children_ids(item)

    count_products = ->
      for item in $scope.currentStore.products
        if item.category_id.$oid of $scope.cats_counter
          $scope.cats_counter[item.category_id.$oid] += 1
        else
          for subcat in $scope.categories
            if item.category_id.$oid in subcat.children_ids
              $scope.cats_counter[subcat.id] += 1
              break

    $q.all([Store.all().$promise, Category.all().$promise]).then (results) ->
      $scope.currentStore = $filter('getBySlug')(results[0], $routeParams.store_slug)

      $scope.categories = results[1]

      Store.popular($scope.currentStore.user_id).then (result) ->
        $scope.currentStore.popular = result

      Store.products($scope.currentStore.user_id).$promise.then (result) ->
        $scope.currentStore.products = result

        # считаем товары по категориям
        create_counters()

        count_products()


    #filtering
    $scope.filter =
      subcats: []

    $scope.toggleSubcat = (subcat_id, chidren_ids) ->
      ids = chidren_ids.concat subcat_id
      for id in ids
        idx = $scope.filter.subcats.indexOf(id)
        if idx > -1
          $scope.filter.subcats.splice(idx, 1)
        else
          $scope.filter.subcats.push(id)


    $scope.filteredProducts = () ->
      result = $scope.currentStore.products
      filter = $scope.filter

      # string search
      result = filterFilter(result, filter.query) if filter.query

      # price range
      result = $filter('priceRangeStore')(result, filter)

      # by subcategory
      result = $filter('productByCategory')(result, filter)

      $scope.numberOfPages = Math.ceil(result.length/SortingCatalog.pageSize) if result
      return result
]
