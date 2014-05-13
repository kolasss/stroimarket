app.controller 'CategoryCtrl',
  ['$scope', 'Category', '$routeParams', '$filter',
  ($scope, Category, $routeParams, $filter) ->

    $scope.categories = Category.all()

    $scope.$watchCollection 'categories', (newCats, oldCats) ->
      $scope.currentCategory = $filter('getBySlug')($scope.categories, $routeParams.category_slug)
      $scope.currentCategory.products = Category.show($scope.currentCategory.id) if $scope.currentCategory?
      # console.log $scope.currentCategory


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
