app.controller 'StoreCtrl',
  ['$scope', 'Store', '$routeParams', '$filter',
  ($scope, Store, $routeParams, $filter) ->

    $scope.stores = Store.all()

    $scope.$watchCollection 'stores', (newStores, oldStores) ->
      $scope.currentStore = $filter('getBySlug')($scope.stores, $routeParams.store_slug)
      $scope.currentStore.products = Store.show($scope.currentStore.user_id) if $scope.currentStore?
]
