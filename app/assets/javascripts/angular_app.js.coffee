window.app = angular.module "Stroimarket", [
  'ngRoute'
  'ngResource'
  'ngSanitize'
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
        controller: 'StoreMainCtrl'
      .when '/stores/:store_slug/services',
        templateUrl: '/templates/stores/services.html',
        controller: 'StoreServicesCtrl'
      .when '/stores/:store_slug/about',
        templateUrl: '/templates/stores/about.html',
        controller: 'StoreAboutCtrl'

      .when '/service_categories',
        templateUrl: '/templates/service_categories/index.html',
        controller: 'ServiceCategoriesCtrl'

      .when '/services/:service_id',
        templateUrl: '/templates/services/show.html',
        controller: 'ServiceCtrl'

      .when '/posts/:post_slug',
        templateUrl: '/templates/posts/show.html',
        controller: 'PostCtrl'

      .when '/articles/:article_slug',
        templateUrl: '/templates/articles/show.html',
        controller: 'ArticleCtrl'

      .when '/search/:query',
        templateUrl: '/templates/search/show.html',
        controller: 'SearchCtrl'

      .when '/manufacturers/:manufacturer_slug',
        templateUrl: '/templates/manufacturers/show.html',
        controller: 'ManufacturerCtrl'

      .otherwise
        redirectTo: '/'

]

window.app.run ['$rootScope', 'stroiUtils',
  ($rootScope, stroiUtils) ->

    $rootScope.stroiUtils = stroiUtils

]
