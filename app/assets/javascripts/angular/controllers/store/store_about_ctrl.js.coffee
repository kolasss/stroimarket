app.controller 'StoreAboutCtrl',
  ['$scope', 'Store', '$routeParams', '$filter',
  ($scope, Store, $routeParams, $filter) ->

    Store.all().$promise.then (result) ->
      $scope.currentStore = $filter('getBySlug')(result, $routeParams.store_slug)

]
