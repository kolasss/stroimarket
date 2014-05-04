app.directive 'categorieslist', ->
  return {
    restrict: 'E'
    replace: true
    scope:
      categoriesData: '='
      # onSelect: '&'
      maxLevel: '@'
      onMain: '@'
    template:
      '<div class="row clearfix categories_list">
        <div class="col-md-4" ng-repeat="item in categoriesData | onMainFilter:onMain">
          <listnode
            item="item"
            category-level="1"
            max-level="{{maxLevel}}"
            on-main="{{onMain}}">
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

      link = "<a ng-click='user_clicks_item(item)'>{{ item.label }}</a>"

      if categoryLevel == maxLevel
        children_list = ''
      else
        children_list = "<div class='subcategories_list' on-main='{{onMain}}'>
          <span ng-repeat='item in item.children | onMainFilter:onMain'>
            <listnode
              item='item'
              category-level='#{nextLevel}'
              max-level='#{maxLevel}'
              on-main='{{onMain}}'>
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
      link: (scope, element, attrs) ->
        categoryLevel = parseInt attrs.categoryLevel
        maxLevel = parseInt attrs.maxLevel || 100

        template = get_template(categoryLevel, maxLevel)

        e = $compile(template)(scope)
        element.replaceWith(e)

        scope.user_clicks_item = (item) ->
          $location.path stroiUtils.getCategoryLink(item)
    }
]

app.filter 'onMainFilter', () ->
  return (items, condition) ->
    return items if condition == undefined || condition == ''

    filtered = []
    angular.forEach items, (item) ->
      filtered.push(item) if item.show_on_main

    return filtered
