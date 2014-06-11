app.controller 'ServiceCtrl',
  ['$scope', 'Service', '$routeParams',
  ($scope, Service, $routeParams) ->

    $scope.service = Service.show($routeParams.service_id)

    $scope.editServicePath = (path) ->
      path.replace(/service_id/, $routeParams.service_id)

]
