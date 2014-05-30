app.controller 'ProductCtrl',
  ['$scope', 'Product', '$routeParams',
  ($scope, Product, $routeParams) ->

    $scope.product = Product.show($routeParams.product_id)

    $scope.editProductPath = (path) ->
      path.replace(/product_id/, $routeParams.product_id)

]
