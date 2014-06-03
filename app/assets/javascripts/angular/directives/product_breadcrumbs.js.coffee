app.directive 'productBreadcrumbs',
  ['stroiUtils',
  (stroiUtils) ->
    return {
      restrict: 'E'
      replace: true
      scope:
        product: '='
      template:
        '<ol class="breadcrumb">
          <li ng-repeat="category in categories">
            <a ng-href="{{link_to(category)}}">
              {{category.title}}
            </a>
          </li>
          <li ng-show="product.manufacturer">
            <a ng-href="{{link_to_manufacturer(product.manufacturer)}}">
              {{product.manufacturer.title}}
            </a>
          </li>
        </ol>'
      link: (scope, element, attrs) ->

        scope.categories = [scope.product.category]

        add_category = (category) ->
          scope.categories.unshift category
          if Object.keys(category.parent).length > 0
            add_category category.parent

        if Object.keys(scope.product.category.parents_tree).length > 0
          scope.categories.unshift scope.product.category.parents_tree
          if Object.keys(scope.product.category.parents_tree.parent).length > 0
            add_category scope.product.category.parents_tree.parent

        scope.link_to = (category) ->
          stroiUtils.path_for('CategoryCtrl', {category_slug: category.slug})

        scope.link_to_manufacturer = (manufacturer) ->
          stroiUtils.path_for('ManufacturerCtrl', {manufacturer_slug: manufacturer.slug}) if manufacturer
    }
]
