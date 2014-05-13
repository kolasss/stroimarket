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

    # $scope.slickConfig =
    #   dots: true

    # $scope.slickHandle = {
    # }

    # $scope.isImage = (media) ->
    #   return media.type == 'img'

    # $scope.media = [
    #   {type: 'img', src: 'http://www.deshow.net/d/file/travel/2009-04/scenic-beauty-of-nature-photography-1-503-2.jpg'}
    #   {type: 'img', src: 'http://www.deshow.net/d/file/travel/2009-04/scenic-beauty-of-nature-photography-1-503-20.jpg'}
    #   {type: 'img', src: 'http://www.deshow.net/d/file/travel/2009-04/scenic-beauty-of-nature-photography-1-503-10.jpg'}
    # ]
]
