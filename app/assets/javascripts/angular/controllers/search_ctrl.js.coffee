app.controller 'SearchCtrl',
  ['$scope', 'Searcher', '$routeParams', '$location', '$q', 'SortingCatalog', 'FilterCatalog', 'Category', 'ServiceCategory',
  ($scope, Searcher, $routeParams, $location, $q, SortingCatalog, FilterCatalog, Category, ServiceCategory) ->

    $scope.SortingCatalog = SortingCatalog

    $scope.currentPage = 0
    $scope.numberOfPages = 0

    $scope.currentServicePage = 0
    $scope.numberOfServicePages = 0

    $scope.FilterCatalog = FilterCatalog

    $scope.current = {}
    $scope.query = $routeParams.query

    #filter and counters
    $scope.priceRange = FilterCatalog.priceRange
    $scope.filter =
      subcats: []
    $scope.cats_counter = {}
    $scope.service_cats_counter = {}
    $scope.checked_cats = {}

    $scope.show_products = false
    $scope.show_services = false
    $scope.show_manufacturers = false

    $scope.loaded = false

    # запрос на сервер
    $q.all([Searcher.show($routeParams.query).$promise, Category.all().$promise, ServiceCategory.all().$promise]).then (results) ->
      $scope.current.products = results[0].products
      $scope.services = results[0].services
      $scope.manufacturers = results[0].manufacturers

      check_redirections()

      $scope.categories = results[1]
      $scope.service_categories = results[2]

      # считаем товары по категориям
      FilterCatalog.initFilterSearch($scope.filter, $scope.current, $scope.services)

      FilterCatalog.count_products_for_store($scope.cats_counter, $scope.categories)

      # считаем услуги по категориям
      FilterCatalog.count_services($scope.service_cats_counter, $scope.service_categories)

    $scope.$on 'ProductNumberOfPages:updated', (event, data) ->
      $scope.numberOfPages = data
    $scope.$on 'ServiceNumberOfPages:updated', (event, data) ->
      $scope.numberOfServicePages = data


    check_redirections = ->
      $scope.pl = $scope.current.products.length
      $scope.sl = $scope.services.length
      $scope.ml = $scope.manufacturers.length

      $scope.found_products = $scope.pl > 0
      $scope.found_services = $scope.sl > 0
      $scope.found_manufacturers = $scope.ml > 0

      if $scope.pl == 1 and $scope.ml == 0 and $scope.sl == 0
        $location.path $scope.stroiUtils.path_for('ProductCtrl', {product_id: $scope.current.products[0]._id.$oid}, false)
      else if $scope.pl == 0 and $scope.ml == 1 and $scope.sl == 0
        $location.path  $scope.stroiUtils.path_for('ManufacturerCtrl', {manufacturer_slug: $scope.manufacturers[0].slug}, false)
      else if $scope.pl == 0 and $scope.ml == 0 and $scope.sl == 1
        $location.path $scope.stroiUtils.path_for('ServiceCtrl', {service_id: $scope.services[0]._id.$oid}, false)
      else if $scope.found_products
        $scope.show_products = true
      else if $scope.found_services
        $scope.show_services = true
      else if $scope.found_manufacturers
        $scope.show_manufacturers = true

      $scope.loaded = true

    $scope.show_tab = (name) ->
      if name == 'products' and $scope.found_products
        $scope.show_products = true
        $scope.show_services = false
        $scope.show_manufacturers = false
        clear_filter()
      else if name == 'services' and $scope.found_services
        $scope.show_products = false
        $scope.show_services = true
        $scope.show_manufacturers = false
        clear_filter()
      else if name == 'manufacturers' and $scope.found_manufacturers
        $scope.show_products = false
        $scope.show_services = false
        $scope.show_manufacturers = true
        clear_filter()

    clear_filter = ->
      $scope.filter = FilterCatalog.clear_filter()
      $scope.checked_cats = {}

    $scope.draw_price = (product) ->
      if product.min_price == product.max_price
        "#{product.min_price} <i class='fa fa-rub'></i>"
      else
        "#{product.min_price} ... #{product.max_price} <i class='fa fa-rub'></i>"


]
