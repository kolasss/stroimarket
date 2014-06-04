app.controller 'ManufacturerCtrl',
  ['$scope', 'Manufacturer', '$routeParams', '$filter', 'filterFilter'
  ($scope, Manufacturer, $routeParams, $filter, filterFilter) ->

    $scope.currentPage = 0
    $scope.pageSize = 10
    $scope.numberOfPages = 0

    $scope.currentManufacturer = {products: []}

    Manufacturer.all().$promise.then (result) ->
      $scope.manufacturers = result
      $scope.currentManufacturer = $filter('getBySlug')($scope.manufacturers, $routeParams.manufacturer_slug)
      $scope.currentManufacturer.products = Manufacturer.show($scope.currentManufacturer._id.$oid)

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

    $scope.filter = {}

    $scope.filteredProducts = () ->
      result = $scope.currentManufacturer.products
      filter = $scope.filter

      # string search
      result = filterFilter(result, filter.query) if filter.query

      # price range
      result = $filter('priceRangeCatalog')(result, filter)

      $scope.numberOfPages = Math.ceil(result.length/$scope.pageSize) if result
      return result
]
