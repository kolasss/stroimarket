app.controller 'ProductsCtrl',
  ['$scope', 'Product', '$routeParams',
  ($scope, Product, $routeParams) ->

    $scope.product = Product.show($routeParams.product_id)

]
