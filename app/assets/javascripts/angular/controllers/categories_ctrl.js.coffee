app.controller 'CategoriesCtrl',
  ['$scope', 'Category', '$timeout', 'Manufacturer',
  ($scope, Category, $timeout, Manufacturer) ->

    $scope.categories = Category.all()

    $scope.manufacturers = Manufacturer.all()

    $timeout ->
      $('ul.nav li.open').removeClass('open')
]
