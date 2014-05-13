window.app = angular.module "Stroimarket", [
  'ngRoute'
  'ngResource'
]

window.app.config ['$routeProvider',
  ($routeProvider) ->
    # $locationProvider.html5Mode true
    $routeProvider
      .when '/',
        templateUrl: '/templates/home/home.html',
        controller: 'HomeCtrl'

      .when '/categories',
        templateUrl: '/templates/categories/index.html',
        controller: 'CategoriesCtrl'
      .when '/categories/:category_slug',
        templateUrl: '/templates/categories/show.html',
        controller: 'CategoryCtrl'

      .when '/products/:product_id',
        templateUrl: '/templates/products/show.html',
        controller: 'ProductCtrl'

      .when '/stores',
        templateUrl: '/templates/stores/index.html',
        controller: 'StoresCtrl'
      .when '/stores/:store_slug',
        templateUrl: '/templates/stores/show.html',
        controller: 'StoreCtrl'

      .when '/service_categories',
        templateUrl: '/templates/service_categories/index.html',
        controller: 'ServiceCategoriesCtrl'
      .when '/service_categories/:category_slug',
        templateUrl: '/templates/service_categories/show.html',
        controller: 'ServiceCategoryCtrl'

      .when '/services/:service_id',
        templateUrl: '/templates/services/show.html',
        controller: 'ServiceCtrl'

      .when '/posts/:post_slug',
        templateUrl: '/templates/posts/show.html',
        controller: 'PostCtrl'

      .otherwise
        redirectTo: '/'

]

window.app.run ['$rootScope', 'stroiUtils',
  ($rootScope, stroiUtils) ->

    $rootScope.stroiUtils = stroiUtils

]
