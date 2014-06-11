app.controller 'ManufacturerCtrl',
  ['$scope', 'Manufacturer', '$routeParams', '$filter', 'filterFilter', 'SortingCatalog',
  ($scope, Manufacturer, $routeParams, $filter, filterFilter, SortingCatalog) ->

    $scope.SortingCatalog = SortingCatalog
    $scope.currentPage = 0
    $scope.numberOfPages = 0

    $scope.currentManufacturer = {products: []}

    Manufacturer.all().$promise.then (result) ->
      $scope.currentManufacturer = $filter('getBySlug')(result, $routeParams.manufacturer_slug)
      $scope.currentManufacturer.products = Manufacturer.show($scope.currentManufacturer._id.$oid)


    #filtering
    $scope.filter = {}

    $scope.filteredProducts = () ->
      result = $scope.currentManufacturer.products
      filter = $scope.filter

      # string search
      result = filterFilter(result, filter.query) if filter.query

      # price range
      result = $filter('priceRangeCatalog')(result, filter)

      $scope.numberOfPages = Math.ceil(result.length/SortingCatalog.pageSize) if result
      return result
]
