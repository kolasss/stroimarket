app.controller 'CategoriesCtrl',
  ['$scope', 'Category',
  ($scope, Category) ->

    $scope.categories = Category.all()

]
