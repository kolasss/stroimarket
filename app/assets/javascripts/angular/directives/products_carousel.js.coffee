app.directive 'productsCarousel',
  ['$timeout', 'stroiUtils',
  ($timeout, stroiUtils) ->
    init_carousel = (element) ->
      carousel = element.children('.products-carousel')
      prev_btn = element.children('.prev')
      next_btn = element.children('.next')
      $timeout ->
        carousel.carouFredSel
          width: '100%'
          auto: false
          prev: prev_btn
          next: next_btn
          transition: true
          swipe:
            onMouse: true
            onTouch: true

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
            "#{product.price} <i class='fa fa-rub'></i>"
          else if product.min_price
            if product.min_price == product.max_price
              "#{product.min_price} <i class='fa fa-rub'></i>"
            else
              "#{product.min_price} ... #{product.max_price} <i class='fa fa-rub'></i>"

    }
]
