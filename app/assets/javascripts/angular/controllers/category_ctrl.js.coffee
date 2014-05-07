app.controller 'CategoryCtrl',
  ['$scope', 'Category', '$routeParams', '$filter',
  ($scope, Category, $routeParams, $filter) ->

    $scope.categories = Category.all()

    $scope.$watchCollection 'categories', (newCats, oldCats) ->
      $scope.currentCategory = $filter('getBySlug')($scope.categories, $routeParams.category_slug)
      $scope.currentCategory.products = Category.show($scope.currentCategory.id) if $scope.currentCategory?

]
