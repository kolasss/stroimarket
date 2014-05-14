app.controller 'PostCtrl',
  ['$scope', 'Post', '$routeParams',
  ($scope, Post, $routeParams) ->

    $scope.post = Post.show($routeParams.post_slug)

]
