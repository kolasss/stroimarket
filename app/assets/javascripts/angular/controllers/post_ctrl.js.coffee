app.controller 'PostCtrl',
  ['$scope', 'Post', '$routeParams',
  ($scope, Post, $routeParams) ->

    $scope.post = Post.show($routeParams.post_slug)

    # $scope.$watchCollection 'stores', (newPosts, oldPosts) ->
    #   $scope.currentPost = $filter('getBySlug')($scope.stores, $routeParams.store_slug)
    #   $scope.currentPost.products = Post.show($scope.currentPost.user_id) if $scope.currentPost?
]
