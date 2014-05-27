app.controller 'SearchCtrl',
  ['$scope', 'Searcher', '$routeParams', '$location',
  ($scope, Searcher, $routeParams, $location) ->

    Searcher.show($routeParams.query).$promise.then (result) ->
      $scope.products = result.products
      $scope.manufacturers = result.manufacturers
      $scope.services = result.services

      $scope.pl = $scope.products.length
      $scope.ml = $scope.manufacturers.length
      $scope.sl = $scope.services.length

      if $scope.pl == 1 and $scope.ml == 0 and $scope.sl == 0
        $location.path $scope.stroiUtils.path_for('ProductCtrl', {product_id: $scope.products[0]._id.$oid}, false)
      else if $scope.pl == 0 and $scope.ml == 1 and $scope.sl == 0
        # $location.path  $scope.stroiUtils.path_for('ManufacturerCtrl', {product_id: product._id.$oid}, false)
      else if $scope.pl == 0 and $scope.ml == 0 and $scope.sl == 1
        $location.path $scope.stroiUtils.path_for('ServiceCtrl', {service_id: $scope.services[0]._id.$oid}, false)

    # paging products
    $scope.currentPage = 0
    $scope.pageSize = 10
    $scope.numberOfPages = 0

    # sorting products
    $scope.sorting_by =
      min_price: 'цене'
      updated_at: 'новизне'
      views: 'популярности'

    $scope.sort = {
      column: null,
      descending: false
    };

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

]
