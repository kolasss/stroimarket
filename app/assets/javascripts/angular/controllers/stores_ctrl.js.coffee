app.controller 'StoresCtrl',
  ['$scope', 'Store', '$routeParams',
  ($scope, Store, $routeParams) ->

    # $scope.showProducts = false

    $scope.stores = Store.all()

    $scope.$watchCollection 'stores', (newStores, oldStores) ->
      $scope.setCurrentStore()

    $scope.loadStore = (store) ->
      store.products = Store.show(store.user._id.$oid) if not store.products?
      $scope.productsList = store.products
      # $scope.showProducts = true

    $scope.setCurrentStore = ->
      $scope.currentStore = Store.getCurrent($routeParams.store_slug)
      if $scope.currentStore
        $scope.loadStore $scope.currentStore

]
