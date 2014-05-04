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
        templateUrl: '/templates/home/home.html',
        controller: 'HomeCtrl'
      .when '/categories',
        templateUrl: '/templates/categories/index.html',
        controller: 'CategoriesCtrl',
      .when '/categories/:category_slug',
        templateUrl: '/templates/categories/show.html',
        controller: 'CategoryCtrl',
      .when '/products/:product_id',
        templateUrl: '/templates/products/show.html',
        controller: 'ProductCtrl'
      .when '/stores',
        templateUrl: '/templates/stores/index.html',
        controller: 'StoresCtrl',
      .when '/stores/:store_slug',
        templateUrl: '/templates/stores/show.html',
        controller: 'StoreCtrl',
      .otherwise
        redirectTo: '/'

]

window.app.run ['$route', '$rootScope', 'stroiUtils',
  ($route, $rootScope, stroiUtils) ->

    # $rootScope.stroiUtils = stroiUtils

    $rootScope.path_for = (controller, params) ->
      for path of $route.routes
        pathController = $route.routes[path].controller
        if pathController == controller
          result = path
          for param of params
            result = '#' + result.replace(':' + param, params[param])
          return result

      return undefined
]
