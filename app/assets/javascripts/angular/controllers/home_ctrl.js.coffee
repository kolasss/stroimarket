app.controller 'HomeCtrl',
  ['$scope', 'Post', 'Product',
  ($scope, Post, Product) ->

    Post.all().$promise.then (result) ->
      $scope.posts = result
      $scope.currentPost = $scope.posts[0]


    $scope.setActive = (post) ->
      $scope.currentPost = post

    $scope.linkToCurrentPost = ->
      if $scope.currentPost?
        if $scope.currentPost.url
          $scope.currentPost.url
        else
          $scope.stroiUtils.path_for('PostCtrl', {post_slug: $scope.currentPost.slug})

    $scope.popular = Product.popular()

]
