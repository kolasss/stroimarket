app.controller 'StoreCatalogCtrl',
  ['$scope', 'Store', '$routeParams', '$filter',
  ($scope, Store, $routeParams, $filter) ->

    Store.all().$promise.then (result) ->
      $scope.stores = result
      $scope.currentStore = $filter('getBySlug')($scope.stores, $routeParams.store_slug)

      Store.products($scope.currentStore.user_id).$promise.then (result) ->
        $scope.currentStore.products = result

]
