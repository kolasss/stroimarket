app.controller 'StoreServicesCtrl',
  ['$scope', 'Store', '$routeParams', '$filter',
  ($scope, Store, $routeParams, $filter) ->

    Store.all().$promise.then (result) ->
      $scope.currentStore = $filter('getBySlug')(result, $routeParams.store_slug)

      Store.services($scope.currentStore.user_id).$promise.then (result) ->
        $scope.currentStore.services = result
]
