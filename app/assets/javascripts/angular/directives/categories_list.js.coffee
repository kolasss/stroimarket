app.directive 'categorieslist', ->
  return {
    restrict: 'E'
    replace: true
    scope:
      categoriesData: '='
      # onSelect: '&'
      maxLevel: '@'
      onMain: '@'
      type: '@'
    template:
      '<div class="row clearfix categories_list">
        <div class="col-md-4" ng-repeat="item in categoriesData">
          <listnode
            item="item"
            category-level="1"
            max-level="{{maxLevel}}"
            on-main="{{onMain}}"
            type="{{type}}">
          </listnode>
        </div>
      </div>'
    # link: (scope, element, attrs) ->
  }

app.directive 'listnode',
  ['$compile', '$location', 'stroiUtils',
  ($compile, $location, stroiUtils) ->
    get_template = (categoryLevel, maxLevel) ->
      nextLevel = categoryLevel + 1

      # if categoryLevel == 1
      #   wrap_start = '<div class="category_item">'
      #   wrap_end = '</div>'
      # else
      #   wrap_start = '<li class="category_item">'
      #   wrap_end = '</li>'

      # wrap_start = '<div class="category_item">'
      # wrap_end = '</div>'

      link = "<a type='{{type}}' ng-click='user_clicks_item(item)'>{{ item.title }}</a>"

      if categoryLevel == maxLevel
        children_list = ''
      else
        children_list = "<div class='subcategories_list' on-main='{{onMain}}'>
          <span ng-repeat='item in item.children'>
            <listnode
              item='item'
              category-level='#{nextLevel}'
              max-level='#{maxLevel}'
              on-main='{{onMain}}'
              type='{{type}}'>
            </listnode>
          </span>
        </div>"

      # template = wrap_start + link + children_list + wrap_end
      template = link + children_list

    return {
      restrict: 'E'
      scope:
        item: '='
        onMain: '@'
        type: '@'
      link: (scope, element, attrs) ->
        categoryLevel = parseInt attrs.categoryLevel
        maxLevel = parseInt attrs.maxLevel || 100

        template = get_template(categoryLevel, maxLevel)

        e = $compile(template)(scope)
        element.replaceWith(e)

        scope.user_clicks_item = (item) ->
          if scope.type == 'service'
            item_controller = 'ServiceCategoryCtrl'
          else
            item_controller = 'CategoryCtrl'
          $location.path stroiUtils.path_for(item_controller, {category_slug: item.slug}, false)
    }
]
