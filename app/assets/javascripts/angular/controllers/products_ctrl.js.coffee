app.controller 'ProductsCtrl', ['$scope', 'Product', '$filter', '$routeParams', ($scope, Product, $filter, $routeParams) ->

  $scope.currentProduct = Product.show($routeParams.product_id)

]
