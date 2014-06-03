app.controller 'ProductCtrl',
  ['$scope', 'Product', '$routeParams', 'Category', '$filter',
  ($scope, Product, $routeParams, Category, $filter) ->

    $scope.product = Product.show($routeParams.product_id)

    $scope.editProductPath = (path) ->
      path.replace(/product_id/, $routeParams.product_id)

]
