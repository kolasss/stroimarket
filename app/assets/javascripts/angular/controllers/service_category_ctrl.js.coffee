app.controller 'ServiceCategoryCtrl',
  ['$scope', 'ServiceCategory', '$routeParams', '$filter',
  ($scope, ServiceCategory, $routeParams, $filter) ->

    ServiceCategory.all().$promise.then (result) ->
      $scope.categories = result
      $scope.currentCategory = $filter('getBySlug')($scope.categories, $routeParams.category_slug)
      $scope.currentCategory.services = ServiceCategory.show($scope.currentCategory.id)

]
