app.controller 'ServiceCtrl',
  ['$scope', 'Service', '$routeParams',
  ($scope, Service, $routeParams) ->

    $scope.service = Service.show($routeParams.service_id)
    $scope.service_id = $routeParams.service_id

]
