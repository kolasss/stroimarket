app.controller 'ArticleCtrl',
  ['$scope', 'Article', '$routeParams',
  ($scope, Article, $routeParams) ->

    $scope.article = Article.show($routeParams.article_slug)

]
