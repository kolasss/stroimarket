app.controller 'CategoryCtrl',
  ['$scope', 'Category', '$routeParams', '$filter', 'Manufacturer', '$q', 'filterFilter',
  ($scope, Category, $routeParams, $filter, Manufacturer, $q, filterFilter) ->

    $scope.currentPage = 0
    $scope.pageSize = 10
    $scope.numberOfPages = 0

    $scope.currentCategory = {products: []}

    $q.all([Category.all().$promise, Manufacturer.all().$promise]).then (results) ->
      $scope.categories = results[0]
      $scope.currentCategory = $filter('getBySlug')($scope.categories, $routeParams.category_slug)

      $scope.manufacturers = $filter('manufacturerByCategory')(results[1], $scope.currentCategory)

      Category.show($scope.currentCategory.id).$promise.then (result) ->
        $scope.currentCategory.products = result

        # считаем товары по производителям и подкатегориям
        $scope.manufacturers_counter = {}
        $scope.subcats_counter = {}

        angular.forEach $scope.manufacturers, (item) ->
          $scope.manufacturers_counter[item.title] = 0

        angular.forEach $scope.currentCategory.children, (item) ->
          $scope.subcats_counter[item.id] = 0

        angular.forEach $scope.currentCategory.products, (item) ->
          $scope.manufacturers_counter[item.manufacturer_title] += 1 if item.manufacturer_title
          $scope.subcats_counter[item.category_id.$oid] += 1 if item.category_id.$oid != $scope.currentCategory.id

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

    $scope.toggleSubcat = (subcat_id) ->
      idx = $scope.filter.subcats.indexOf(subcat_id)
      if idx > -1
        $scope.filter.subcats.splice(idx, 1)
      else
        $scope.filter.subcats.push(subcat_id)

    $scope.filteredProducts = () ->
      result = $scope.currentCategory.products
      filter = $scope.filter

      # string search
      result = filterFilter(result, filter.query) if filter.query

      # price range
      result = $filter('priceRange')(result, filter)

      # by manufacturer
      result = $filter('productByManufacturer')(result, filter)

      # by subcategory
      result = $filter('productByCategory')(result, filter)

      $scope.numberOfPages = Math.ceil(result.length/$scope.pageSize) if result
      return result

]
