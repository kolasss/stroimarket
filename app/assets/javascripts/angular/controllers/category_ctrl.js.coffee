app.controller 'CategoryCtrl',
  ['$scope', 'Category', '$routeParams', '$filter', 'Manufacturer', '$q', 'SortingCatalog', 'FilterCatalog',
  ($scope, Category, $routeParams, $filter, Manufacturer, $q, SortingCatalog, FilterCatalog) ->

    $scope.SortingCatalog = SortingCatalog
    $scope.currentPage = 0
    $scope.numberOfPages = 0

    $scope.FilterCatalog = FilterCatalog

    #filter and counters
    $scope.priceRange = FilterCatalog.priceRange
    $scope.filter =
      manufacturers: []
      subcats: []
    $scope.manufacturers_counter = {}
    $scope.subcats_counter = {}

    # запрос на сервер
    $q.all([Category.all().$promise, Manufacturer.all().$promise]).then (results) ->
      $scope.currentCategory = $filter('getBySlug')(results[0], $routeParams.category_slug)

      $scope.manufacturers = $filter('manufacturerByCategory')(results[1], $scope.currentCategory)

      Category.show($scope.currentCategory.id).$promise.then (result) ->
        $scope.currentCategory.products = result

        # считаем товары по производителям и подкатегориям
        FilterCatalog.initFilter($scope.filter, $scope.currentCategory)

        FilterCatalog.count_products_for_category($scope.subcats_counter, $scope.manufacturers_counter, $scope.manufacturers)

    $scope.$on 'ProductNumberOfPages:updated', (event, data) ->
      $scope.numberOfPages = data

    $scope.draw_price = (product) ->
      if product.min_price == product.max_price
        "#{product.min_price} <i class='fa fa-rub'></i>"
      else
        "#{product.min_price} ... #{product.max_price} <i class='fa fa-rub'></i>"

]
