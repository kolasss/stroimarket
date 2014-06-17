app.controller 'ManufacturerCtrl',
  ['$scope', 'Manufacturer', '$routeParams', '$filter', 'SortingCatalog','$q', 'FilterCatalog', 'Category',
  ($scope, Manufacturer, $routeParams, $filter, SortingCatalog, $q, FilterCatalog, Category) ->

    $scope.SortingCatalog = SortingCatalog
    $scope.currentPage = 0
    $scope.numberOfPages = 0

    $scope.FilterCatalog = FilterCatalog

    #filter and counters
    $scope.filter =
      subcats: []
    $scope.cats_counter = {}

    # запрос на сервер
    $q.all([Manufacturer.all().$promise, Category.all().$promise]).then (results) ->
      $scope.currentManufacturer = $filter('getBySlug')(results[0], $routeParams.manufacturer_slug)
      $scope.categories = results[1]

      Manufacturer.show($scope.currentManufacturer._id.$oid).$promise.then (result) ->
        $scope.currentManufacturer.products = result

        # считаем товары по категориям
        FilterCatalog.initFilter($scope.filter, $scope.currentManufacturer)

        FilterCatalog.count_products_for_store($scope.cats_counter, $scope.categories)

    $scope.$on 'ProductNumberOfPages:updated', (event, data) ->
      $scope.numberOfPages = data

]
