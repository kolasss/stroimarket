app.controller 'SearchFormCtrl',
  ['$scope', '$location',
  ($scope, $location) ->

    $scope.submit = (form) ->
      return if form.$invalid
      $location.path $scope.stroiUtils.path_for('SearchCtrl', {query: $scope.query}, false)
      $scope.query = ''
]
