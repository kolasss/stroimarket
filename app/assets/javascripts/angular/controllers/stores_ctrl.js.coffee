app.controller 'StoresCtrl',
  ['$scope', 'Store', '$routeParams',
  ($scope, Store, $routeParams) ->

    $scope.stores = Store.all()

]
