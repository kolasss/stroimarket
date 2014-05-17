app.controller 'StoreMainCtrl',
  ['$scope', 'Store', '$routeParams', '$filter',
  ($scope, Store, $routeParams, $filter) ->

    Store.all().$promise.then (result) ->
      $scope.stores = result
      $scope.currentStore = $filter('getBySlug')($scope.stores, $routeParams.store_slug)

      Store.popular($scope.currentStore.user_id).then (result) ->
        $scope.currentStore.popular = result

      Store.new_products($scope.currentStore.user_id).then (result) ->
        $scope.currentStore.new_products = result

]
