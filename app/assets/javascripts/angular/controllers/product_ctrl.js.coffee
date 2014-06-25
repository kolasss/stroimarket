app.controller 'ProductCtrl',
  ['$scope', 'Product', '$routeParams',
  ($scope, Product, $routeParams) ->

    $scope.product = Product.show($routeParams.product_id)
    $scope.product_id = $routeParams.product_id

]
