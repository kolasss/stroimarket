app.controller 'CategoryTreeCtrl',
  ['$scope', 'Category', '$routeParams' , '$timeout', '$location',
  ($scope, Category, $routeParams, $timeout, $location) ->

    $scope.categories = Category.all()

    $scope.categories_tree = {}

    $scope.$watchCollection 'categories', (newCats, oldCats) ->
      $scope.setCurrentCategory()

    $scope.$on '$routeChangeSuccess', ->
      $scope.setCurrentCategory()

    $scope.changeCategory = (category) ->
      $location.path $scope.stroiUtils.getCategoryLink(category)

    $scope.setCurrentCategory = ->
      if $routeParams.category_slug
        $scope.currentCategory = Category.getCurrent($routeParams.category_slug)

      if $scope.currentCategory
        $timeout () ->
          $scope.categories_tree.select_branch($scope.currentCategory)

]
