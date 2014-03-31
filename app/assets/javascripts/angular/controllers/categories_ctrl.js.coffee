app.controller 'CategoriesCtrl', ['$scope', 'Category', ($scope, Category) ->
  $scope.showCategory = false
  $scope.showProduct = false

  $scope.categories = Category.all()

  $scope.loadCategory = (category) ->
    category.products = Category.show(category.id) if not category.products?
    $scope.productsList = category.products
    $scope.showCategory = true
    $scope.showProduct = false
    # $scope.selectedCategory = true

  $scope.loadProduct = (product) ->
    $scope.currentProduct = product
    $scope.showCategory = false
    $scope.showProduct = true

  $scope.backToCategory = ->
    $scope.showCategory = true
    $scope.showProduct = false

]
