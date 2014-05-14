app.controller 'StoreCtrl',
  ['$scope', 'Store', '$routeParams', '$filter',
  ($scope, Store, $routeParams, $filter) ->

    Store.all().$promise.then (result) ->
      $scope.stores = result
      $scope.currentStore = $filter('getBySlug')($scope.stores, $routeParams.store_slug)
      $scope.currentStore.products = Store.show($scope.currentStore.user_id)

]
