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
        # templateUrl: '/templates/categories/index.html',
        # controller: 'CategoriesCtrl'
        templateUrl: '/templates/home/home.html',
        controller: 'HomeCtrl'
      .when '/categories/:category_slug',
        templateUrl: '/templates/categories/index.html',
        controller: 'CategoriesCtrl',
      .when '/products/:product_id',
        templateUrl: '/templates/products/show.html',
        controller: 'ProductsCtrl'
      .when '/stores',
        templateUrl: '/templates/stores/index.html',
        controller: 'StoresCtrl',
      .when '/stores/:store_slug',
        templateUrl: '/templates/stores/show.html',
        controller: 'StoresCtrl',
      .otherwise
        redirectTo: '/'

]

window.app.run ($rootScope, stroiUtils) ->
  $rootScope.stroiUtils = stroiUtils
