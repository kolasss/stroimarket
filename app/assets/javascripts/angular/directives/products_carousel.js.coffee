app.directive 'productsCarousel',
  ['$timeout', 'stroiUtils',
  ($timeout, stroiUtils) ->
    init_carousel = (element) ->
      $timeout ->
        element.owlCarousel
          navigation: true
          # rewindSpeed: 200
          navigationText: ['<span class="glyphicon glyphicon-chevron-left"></span>', '<span class="glyphicon glyphicon-chevron-right"></span>']
          pagination: false
          rewindNav: false
          items : 7
          itemsDesktop : [1199,5]
          itemsDesktopSmall : false
          itemsTablet: [768,4]
          itemsMobile : [479,2]
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
            "#{product.price} <span class=rouble>Р</span>"
          else if product.min_price
            "#{product.min_price} ... #{product.max_price} <span class=rouble>Р</span>"

    }
]
