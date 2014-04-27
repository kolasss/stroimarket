app.controller 'HomeCtrl',
  ['$scope', 'Category',
  ($scope, Category) ->

    $scope.categories = Category.all()

]
