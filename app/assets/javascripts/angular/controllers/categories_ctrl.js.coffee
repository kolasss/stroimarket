app.controller 'CategoriesCtrl',
  ['$scope', 'Category', '$timeout'
  ($scope, Category, $timeout) ->

    $scope.categories = Category.all()

    $timeout ->
      $('ul.nav li.open').removeClass('open')
]
