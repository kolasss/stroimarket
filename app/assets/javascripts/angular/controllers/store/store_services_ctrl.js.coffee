app.controller 'StoreServicesCtrl',
  ['$scope', 'Store', '$routeParams', '$filter', 'ServiceCategory', '$q', 'SortingCatalog', 'FilterCatalog',
  ($scope, Store, $routeParams, $filter, ServiceCategory, $q, SortingCatalog, FilterCatalog) ->

    $scope.SortingCatalog = SortingCatalog
    $scope.currentPage = 0
    $scope.numberOfPages = 0

    $scope.FilterCatalog = FilterCatalog

    #filter and counters
    $scope.priceRange = FilterCatalog.priceRange
    $scope.filter =
      subcats: []
    $scope.cats_counter = {}

    # запрос на сервер
    $q.all([Store.all().$promise, ServiceCategory.all().$promise]).then (results) ->
      $scope.currentStore = $filter('getBySlug')(results[0], $routeParams.store_slug)
      $scope.categories = results[1]

      Store.services($scope.currentStore.user_id).$promise.then (result) ->
        $scope.currentStore.services = result

        # считаем товары по категориям
        FilterCatalog.initFilterServices($scope.filter, $scope.currentStore.services)

        FilterCatalog.count_services($scope.cats_counter, $scope.categories)

    $scope.$on 'ServiceNumberOfPages:updated', (event, data) ->
      $scope.numberOfPages = data

]
