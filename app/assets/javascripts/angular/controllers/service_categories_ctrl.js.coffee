app.controller 'ServiceCategoriesCtrl',
  ['$scope', 'ServiceCategory', 'Service', '$q', 'SortingCatalog', 'FilterCatalog',
  ($scope, ServiceCategory, Service, $q, SortingCatalog, FilterCatalog) ->

    $scope.SortingCatalog = SortingCatalog
    $scope.currentServicePage = 0
    $scope.numberOfServicePages = 0

    $scope.FilterCatalog = FilterCatalog

    #filter and counters
    $scope.priceRange = FilterCatalog.priceRange
    $scope.filter =
      subcats: []
    $scope.cats_counter = {}

    # запрос на сервер
    $q.all([ServiceCategory.all().$promise, Service.all().$promise]).then (results) ->
      $scope.categories = results[0]

      $scope.services = results[1]

      # считаем услуги по категориям
      FilterCatalog.initFilterServices($scope.filter, $scope.services)

      FilterCatalog.count_services($scope.cats_counter, $scope.categories)

    $scope.$on 'ServiceNumberOfPages:updated', (event, data) ->
      $scope.numberOfServicePages = data

]
