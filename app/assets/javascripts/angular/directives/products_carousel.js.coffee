app.directive 'productsCarousel',
  ['$timeout', 'stroiUtils',
  ($timeout, stroiUtils) ->
    init_carousel = (element) ->
      $timeout ->
        element.owlCarousel
          navigation: true
    return {
      restrict: 'E'
      scope:
        products: '='
        store: '@'
      replace: true
      templateUrl: 'templates/products/carousel.html'
      link: (scope, element, attrs) ->
        scope.$watchCollection 'products', (newVal, oldVal) ->
          if scope.store
            if newVal
              init_carousel element
          else if newVal.$resolved
            init_carousel element

        scope.link_to = (product) ->
          stroiUtils.path_for('ProductCtrl', {product_id: product._id.$oid})

        scope.draw_price = (product) ->
          if scope.store
            product.price
          else
            "#{product.min_price} ... #{product.max_price}"


    }
]
