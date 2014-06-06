app.controller 'ServiceCategoriesCtrl',
  ['$scope', 'ServiceCategory', 'Service', '$filter', '$q', 'filterFilter',
  ($scope, ServiceCategory, Service, $filter, $q, filterFilter) ->

    $scope.currentPage = 0
    $scope.pageSize = 10
    $scope.numberOfPages = 0

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

      # считаем товары по производителям и подкатегориям
      create_counters()

      count_products()


    # sorting
    $scope.sorting_by =
      price: 'цене'
      updated_at: 'новизне'
      views: 'популярности'

    $scope.sort =
      column: null,
      descending: false

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

      $scope.numberOfPages = Math.ceil(result.length/$scope.pageSize) if result
      return result
]
