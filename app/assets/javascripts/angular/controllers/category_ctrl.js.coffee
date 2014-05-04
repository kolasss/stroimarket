app.controller 'CategoryCtrl',
  ['$scope', 'Category', '$routeParams',
  ($scope, Category, $routeParams) ->

    $scope.categories = Category.all()

    $scope.$watchCollection 'categories', (newCats, oldCats) ->
      $scope.setCurrentCategory()

    $scope.loadCategory = (category) ->
      category.products = Category.show(category.id) if not category.products?
      $scope.productsList = category.products

    $scope.setCurrentCategory = ->
      $scope.currentCategory = Category.getCurrent($routeParams.category_slug)
      if $scope.currentCategory
        $scope.loadCategory $scope.currentCategory

]
