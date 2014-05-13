app.directive 'owlCarousel', ['$timeout', ($timeout) ->
  return {
    restrict: 'E'
    scope:
      products: '='
    replace: true
    template:
      '<div class="owl-carousel owl-theme">
        <div class="item" ng-repeat="product in products">
          <div class="thumbnail">
            <img ng-src="{{product.cover.thumb.url}}" alt="{{product.title}}">
            <div class="caption">
              <p> {{product.title}} </p>
            </div>
          </div>
        </div>
      </div>'
    link: (scope, element, attrs) ->
      scope.$watchCollection 'products', (newVal, oldVal) ->
        return if newVal == oldVal
        if newVal.$resolved
          $timeout ->
            element.owlCarousel
              navigation: true

  }
]
