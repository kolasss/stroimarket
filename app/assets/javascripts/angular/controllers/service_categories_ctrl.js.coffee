app.controller 'ServiceCategoriesCtrl',
  ['$scope', 'ServiceCategory',
  ($scope, ServiceCategory) ->

    $scope.categories = ServiceCategory.all()

]
