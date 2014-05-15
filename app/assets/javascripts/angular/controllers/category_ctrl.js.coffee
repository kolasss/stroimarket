app.controller 'CategoryCtrl',
  ['$scope', 'Category', '$routeParams', '$filter', 'Manufacturer', '$q'
  ($scope, Category, $routeParams, $filter, Manufacturer, $q) ->

    $q.all([Category.all().$promise, Manufacturer.all().$promise]).then (results) ->
      $scope.categories = results[0]
      $scope.currentCategory = $filter('getBySlug')($scope.categories, $routeParams.category_slug)

      $scope.manufacturers = $filter('manufacturerByCategory')(results[1], $scope.currentCategory)

      # $scope.currentCategory.products = Category.show($scope.currentCategory.id)
      Category.show($scope.currentCategory.id).$promise.then (result) ->
        $scope.currentCategory.products = result

        $scope.manufacturers_counter = {}
        angular.forEach $scope.manufacturers, (item) ->
          $scope.manufacturers_counter[item.title] = 0

        angular.forEach $scope.currentCategory.products, (item) ->
          $scope.manufacturers_counter[item.manufacturer_title] += 1 if item.manufacturer_title


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
