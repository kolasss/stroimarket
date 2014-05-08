app.controller 'HomeCtrl',
  ['$scope', 'Post', 'Product',
  ($scope, Post, Product) ->

    # $scope.categories = Category.all()

    $scope.posts = Post.all()

    $scope.$watchCollection 'posts', (newCollection, oldCollection) ->
      $scope.currentPost = $scope.posts[0]

    $scope.setActive = (post) ->
      $scope.currentPost = post

    $scope.popular = Product.popular()
]
