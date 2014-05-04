app.controller 'StoreCtrl',
  ['$scope', 'Store', '$routeParams',
  ($scope, Store, $routeParams) ->

    $scope.stores = Store.all()

    $scope.$watchCollection 'stores', (newStores, oldStores) ->
      $scope.setCurrentStore()

    $scope.loadStore = (store) ->
      store.products = Store.show(store.user._id.$oid) if not store.products?
      $scope.productsList = store.products

    $scope.setCurrentStore = ->
      $scope.currentStore = Store.getCurrent($routeParams.store_slug)
      if $scope.currentStore
        $scope.loadStore $scope.currentStore

]
