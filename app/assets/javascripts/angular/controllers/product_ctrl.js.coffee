app.controller 'ProductCtrl',
  ['$scope', 'Product', '$routeParams',
  ($scope, Product, $routeParams) ->

    $scope.product = Product.show($routeParams.product_id)
    $scope.product_id = $routeParams.product_id

    $scope.draw_price = ->
      if $scope.product.min_price == $scope.product.max_price
        "#{$scope.product.min_price} <i class='fa fa-rub'></i>"
      else
        "#{$scope.product.min_price} ... #{$scope.product.max_price} <i class='fa fa-rub'></i>"
]
