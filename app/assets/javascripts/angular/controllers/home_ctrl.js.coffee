app.controller 'HomeCtrl',
  ['$scope', 'Post', 'Product',
  ($scope, Post, Product) ->

    Post.all().$promise.then (result) ->
      $scope.posts = result
      $scope.currentPost = $scope.posts[0]


    $scope.setActive = (post) ->
      $scope.currentPost = post

    $scope.popular = Product.popular()

]
