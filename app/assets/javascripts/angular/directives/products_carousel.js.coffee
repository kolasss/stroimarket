app.directive 'productsCarousel',
  ['$timeout', 'stroiUtils',
  ($timeout, stroiUtils) ->
    return {
      restrict: 'E'
      scope:
        products: '='
      replace: true
      templateUrl: 'templates/products/popular.html'
      link: (scope, element, attrs) ->
        scope.$watchCollection 'products', (newVal, oldVal) ->
          if newVal.$resolved
            $timeout ->
              element.owlCarousel
                navigation: true

        scope.link_to = (product) ->
          stroiUtils.path_for('ProductCtrl', {product_id: product._id.$oid})

    }
]
