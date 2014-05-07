app.controller 'ServiceCtrl',
  ['$scope', 'Service', '$routeParams',
  ($scope, Service, $routeParams) ->

    $scope.service = Service.show($routeParams.service_id)

]
