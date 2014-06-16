app.controller 'StoreMainCtrl',
  ['$scope', 'Store', '$routeParams', '$filter', 'Category', '$q', 'SortingCatalog', 'FilterCatalog',
  ($scope, Store, $routeParams, $filter, Category, $q, SortingCatalog, FilterCatalog) ->

    $scope.SortingCatalog = SortingCatalog
    $scope.currentPage = 0
    $scope.numberOfPages = 0

    $scope.FilterCatalog = FilterCatalog

    #filter and counters
    $scope.filter =
      subcats: []
    $scope.cats_counter = {}

    # запрос на сервер
    $q.all([Store.all().$promise, Category.all().$promise]).then (results) ->
      $scope.currentStore = $filter('getBySlug')(results[0], $routeParams.store_slug)
      $scope.categories = results[1]

      Store.popular($scope.currentStore.user_id).then (result) ->
        $scope.currentStore.popular = result

      Store.products($scope.currentStore.user_id).$promise.then (result) ->
        $scope.currentStore.products = result

        # считаем товары по категориям
        FilterCatalog.initFilter($scope.filter, $scope.currentStore)

        FilterCatalog.count_products_for_store($scope.cats_counter, $scope.categories)

    $scope.$on 'ProductNumberOfPages:updated', (event, data) ->
      $scope.numberOfPages = data

]
