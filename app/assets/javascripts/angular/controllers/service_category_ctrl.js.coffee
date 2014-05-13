app.controller 'ServiceCategoryCtrl',
  ['$scope', 'ServiceCategory', '$routeParams', '$filter',
  ($scope, ServiceCategory, $routeParams, $filter) ->

    $scope.categories = ServiceCategory.all()

    $scope.$watchCollection 'categories', (newCats, oldCats) ->
      $scope.currentCategory = $filter('getBySlug')($scope.categories, $routeParams.category_slug)
      $scope.currentCategory.services = ServiceCategory.show($scope.currentCategory.id) if $scope.currentCategory?

]
