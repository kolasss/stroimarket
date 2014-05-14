app.controller 'CategoryCtrl',
  ['$scope', 'Category', '$routeParams', '$filter', 'Manufacturer', '$q'
  ($scope, Category, $routeParams, $filter, Manufacturer, $q) ->

    $q.all([Category.all().$promise, Manufacturer.all().$promise]).then (results) ->
      $scope.categories = results[0]
      $scope.currentCategory = $filter('getBySlug')($scope.categories, $routeParams.category_slug)
      $scope.currentCategory.products = Category.show($scope.currentCategory.id)

      $scope.manufacturers = $filter('manufacturerByCategory')(results[1], $scope.currentCategory)


    # sorting
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

    #filtering
    $scope.filter = {manufacturers: []}

    $scope.toggleBrand = (manufacturer) ->
      idx = $scope.filter.manufacturers.indexOf(manufacturer)
      if idx > -1
        $scope.filter.manufacturers.splice(idx, 1)
      else
        $scope.filter.manufacturers.push(manufacturer)

]
