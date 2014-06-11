app.controller 'ServiceCategoriesCtrl',
  ['$scope', 'ServiceCategory', 'Service', '$filter', '$q', 'filterFilter', 'SortingCatalog',
  ($scope, ServiceCategory, Service, $filter, $q, filterFilter, SortingCatalog) ->

    $scope.SortingCatalog = SortingCatalog
    $scope.currentPage = 0
    $scope.numberOfPages = 0

    #counters
    create_counters = ->
      $scope.subcats_counter = {}

      for item in $scope.categories
        $scope.subcats_counter[item._id.$oid] = 0

    count_products = ->
      for item in $scope.services
        $scope.subcats_counter[item.service_category_id.$oid] += 1

    $q.all([ServiceCategory.all().$promise, Service.all().$promise]).then (results) ->
      $scope.categories = results[0]

      $scope.services = results[1]

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
      result = $scope.services
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
