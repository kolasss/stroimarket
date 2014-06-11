app.controller 'StoreServicesCtrl',
  ['$scope', 'Store', '$routeParams', '$filter', 'ServiceCategory', '$q', 'filterFilter', 'SortingCatalog',
  ($scope, Store, $routeParams, $filter, ServiceCategory, $q, filterFilter, SortingCatalog) ->

    $scope.SortingCatalog = SortingCatalog
    $scope.currentPage = 0
    $scope.numberOfPages = 0

    $scope.currentStore = {services: []}

    #counters
    create_counters = ->
      $scope.subcats_counter = {}

      for item in $scope.categories
        $scope.subcats_counter[item._id.$oid] = 0

    count_products = ->
      for item in $scope.currentStore.services
        $scope.subcats_counter[item.service_category_id.$oid] += 1

    $q.all([Store.all().$promise, ServiceCategory.all().$promise]).then (results) ->
      $scope.currentStore = $filter('getBySlug')(results[0], $routeParams.store_slug)
      $scope.categories = results[1]

      Store.services($scope.currentStore.user_id).$promise.then (result) ->
        $scope.currentStore.services = result

        # считаем товары по категориям
        create_counters()

        count_products()


    #filtering
    $scope.filter =
      subcats: []

    $scope.toggleSubcat = (subcat_id) ->
      idx = $scope.filter.subcats.indexOf(subcat_id)
      if idx > -1
        $scope.filter.subcats.splice(idx, 1)
      else
        $scope.filter.subcats.push(subcat_id)

    $scope.filteredServices = () ->
      result = $scope.currentStore.services
      filter = $scope.filter

      # string search
      result = filterFilter(result, filter.query) if filter.query

      # price range
      result = $filter('priceRangeStore')(result, filter)

      # by subcategory
      result = $filter('serviceByCategory')(result, filter)

      $scope.numberOfPages = Math.ceil(result.length/SortingCatalog.pageSize) if result
      return result
]
