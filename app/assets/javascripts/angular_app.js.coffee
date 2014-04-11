window.app = angular.module "Stroimarket", [
  'ngRoute',
  'ngResource',
  'angularBootstrapNavTree'
]

window.app.config ['$routeProvider', '$locationProvider',
  ($routeProvider, $locationProvider) ->
    # $locationProvider.html5Mode true
    $routeProvider
      .when '/',
        templateUrl: '/templates/categories/index.html',
        controller: 'CategoriesCtrl'
      .when '/:category_slug',
        templateUrl: '/templates/categories/index.html',
        controller: 'CategoriesCtrl',
      .when '/products/:product_id',
        templateUrl: '/templates/products/show.html',
        controller: 'ProductsCtrl'
      .otherwise
        redirectTo: '/'

    # $routeProvider.
    #   when('/phones', {
    #     templateUrl: 'partials/phone-list.html',
    #     controller: 'PhoneListCtrl'
    #   }).
    #   when('/phones/:phoneId', {
    #     templateUrl: 'partials/phone-detail.html',
    #     controller: 'PhoneDetailCtrl'
    #   }).
    #   otherwise({
    #     redirectTo: '/phones'
    #   });
]
