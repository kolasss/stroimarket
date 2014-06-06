app.controller 'ServiceCategoryCtrl',
  ['$scope', 'ServiceCategory', '$routeParams', '$filter',
  ($scope, ServiceCategory, $routeParams, $filter) ->

    ServiceCategory.all().$promise.then (result) ->
      $scope.currentCategory = $filter('getBySlug')(result, $routeParams.category_slug)
      $scope.currentCategory.services = ServiceCategory.show($scope.currentCategory.id)

]
