# app.directive 'categoriesList', ($timeout) ->
#   return {
#     restrict: 'E'
#     # template: "<div class=\"row\">\n
#     #     <div
#     #       t=\"row in tree_rows | filter:{visible:true} track by row.branch.uid\"
#     #       ng-repeat=\"row in tree_rows\"
#     #       ng-animate=\"'abn-tree-animate'\"
#     #       ng-class=\"'level-' + {{ row.level }} + (row.branch.selected ? ' active':'')\"
#     #       class=\"col-md-4\"
#     #     >\n
#     #       <a ng-click=\"user_clicks_branch(row.branch)\">\n
#     #         <span class=\"indented tree-label\">{{ row.label }} </span>\n
#     #       </a>\n
#     #     </div>\n
#     #   </div>"
#     templateUrl: '/templates/categories/list.html'
#     scope:
#       categoriesData: '='
#       onSelect: '&'
#       maxLevel: '='
#       # initialSelection: '@'
#       # treeControl: '='

#     link: (scope, element, attrs) ->

#       if !scope.categoriesData
#         alert('no categoriesData defined for the tree!')
#         return

#       # if scope.treeData.length == null
#       #   if treeData.label != null
#       #     scope.treeData = [treeData]
#       #   else
#       #     alert('treeData should be an array of root branches')
#       #     return

#       # for_each_branch = (f) ->
#       #   do_f = (branch, level) ->
#       #     f(branch, level)
#       #     if branch.children != null
#       #       _ref = branch.children

#       #       # _results = []
#       #       # for (_i = 0, _len = _ref.length; _i < _len; _i++) {
#       #       #   child = _ref[_i]
#       #       #   _results.push(do_f(child, level + 1))
#       #       # }
#       #       _results = (do_f(child, level + 1) for child in _ref)

#       #       return _results

#       #   _ref = scope.treeData

#       #   # _results = []

#       #   # for (_i = 0, _len = _ref.length; _i < _len; _i++) {
#       #   #   root_branch = _ref[_i]
#       #   #   _results.push(do_f(root_branch, 1))
#       #   # }
#       #   _results = (do_f(branch, 1) for branch in _ref)

#       #   return _results

#       # selected_branch = null;

#       # select_branch = function(branch) {
#       #   if (!branch) {
#       #     if (selected_branch != null) {
#       #       selected_branch.selected = false;
#       #     }
#       #     selected_branch = null;
#       #     return;
#       #   }
#       #   if (branch !== selected_branch) {
#       #     if (selected_branch != null) {
#       #       selected_branch.selected = false;
#       #     }
#       #     branch.selected = true;
#       #     selected_branch = branch;
#       #     expand_all_parents(branch);
#       #     if (branch.onSelect != null) {
#       #       return $timeout(function() {
#       #         return branch.onSelect(branch);
#       #       });
#       #     } else {
#       #       if (scope.onSelect != null) {
#       #         return $timeout(function() {
#       #           return scope.onSelect({
#       #             branch: branch
#       #           });
#       #         });
#       #       }
#       #     }
#       #   }
#       # };

#       scope.user_clicks_branch = (branch) ->
#         console.log branch
#         # if (branch !== selected_branch) {
#         #   return select_branch(branch);
#         # } else if (scope.onSelect != null) {
#         #   return $timeout(function() {
#         #     return scope.onSelect({
#         #       branch: branch
#         #     });
#         #   });
#         # }

#       # get_parent = function(child) {
#       #   var parent;
#       #   parent = void 0;
#       #   if (child.parent_uid) {
#       #     for_each_branch(function(b) {
#       #       if (b.uid === child.parent_uid) {
#       #         return parent = b;
#       #       }
#       #     });
#       #   }
#       #   return parent;
#       # };

#       # for_all_ancestors = function(child, fn) {
#       #   var parent;
#       #   parent = get_parent(child);
#       #   if (parent != null) {
#       #     fn(parent);
#       #     return for_all_ancestors(parent, fn);
#       #   }
#       # };

#       # expand_all_parents = function(child) {
#       #   return for_all_ancestors(child, function(b) {
#       #     return b.expanded = true;
#       #   });
#       # };

#       # scope.tree_rows = []

#       # on_treeData_change = () ->
#       #   for_each_branch (b, level) ->
#       #     if !b.uid
#       #       return b.uid = "" + Math.random()

#       #   for_each_branch (b) ->
#       #     if angular.isArray(b.children)
#       #       _ref = b.children

#       #       # _results = []
#       #       # for (_i = 0, _len = _ref.length; _i < _len; _i++) {
#       #       #   child = _ref[_i]
#       #       #   _results.push(child.parent_uid = b.uid)
#       #       # }
#       #       _results = (child.parent_uid = b.uid for child in _ref)

#       #       return _results

#       #   scope.tree_rows = []

#       #   # for_each_branch (branch) ->
#       #   #   if branch.children
#       #   #     if branch.children.length > 0
#       #   #       return branch.children = branch.children.map (e) ->
#       #   #         if typeof e == 'string'
#       #   #           return {
#       #   #             label: e
#       #   #             children: []
#       #   #           }
#       #   #         else
#       #   #           return e
#       #   #   else
#       #   #     return branch.children = []

#       #   add_branch_to_list = (level, branch, visible) ->
#       #     # if branch.expanded == null
#       #     #   branch.expanded = false

#       #     # if !branch.children || branch.children.length == 0
#       #     #   tree_icon = attrs.iconLeaf
#       #     # else
#       #     #   if branch.expanded
#       #     #     tree_icon = attrs.iconCollapse
#       #     #   else
#       #     #     tree_icon = attrs.iconExpand

#       #     scope.tree_rows.push({
#       #       level: level
#       #       branch: branch
#       #       label: branch.label
#       #       # tree_icon: tree_icon
#       #       visible: visible
#       #     })

#       #     if branch.children != null
#       #       _ref = branch.children

#       #       _results = []
#       #       # for (_i = 0, _len = _ref.length; _i < _len; _i++) {
#       #       #   child = _ref[_i]
#       #       #   child_visible = visible && branch.expanded
#       #       #   _results.push(add_branch_to_list(level + 1, child, child_visible))
#       #       # }

#       #       for child in _ref
#       #         child_visible = visible && branch.expanded
#       #         _results.push(add_branch_to_list(level + 1, child, child_visible))

#       #       return _results

#       #   _ref = scope.treeData

#       #   # _results = []
#       #   # for (_i = 0, _len = _ref.length; _i < _len; _i++) {
#       #   #   root_branch = _ref[_i]
#       #   #   _results.push(add_branch_to_list(1, root_branch, true))
#       #   # }
#       #   _results = (add_branch_to_list(1, root_branch, true) for root_branch in _ref)

#       #   return _results

#       # scope.$watch('treeData', on_treeData_change, true)

#       # if (attrs.initialSelection != null) {
#       #   for_each_branch(function(b) {
#       #     if (b.label === attrs.initialSelection) {
#       #       return $timeout(function() {
#       #         return select_branch(b);
#       #       });
#       #     }
#       #   });
#       # }

#       # n = scope.treeData.length;
#       # for_each_branch (b, level) ->
#       #   b.level = level
#       #   return b.expanded = b.level < expand_level


#   }



app.directive 'categorieslist', ->
  return {
    restrict: 'E'
    replace: true
    scope:
      categoriesData: '='
      onSelect: '&'
      maxLevel: '='
    template:
      '<div class="row clearfix">
        <div class="col-md-4" ng-repeat="item in categoriesData">
          <listnode item="item" category-level="1" max-level="{{maxLevel}}">
          </listnode>
        </div>
      </div>'
  }

app.directive 'listnode', ($compile) ->
  get_template = (categoryLevel, maxLevel) ->
    nextLevel = categoryLevel + 1

    if categoryLevel == 1
      wrap_start = '<div class="category_item">'
      wrap_end = '</div>'
    else
      wrap_start = '<li class="category_item">'
      wrap_end = '</li>'

    link = "<a
      ng-click='user_clicks_item(item)'
      category-level='#{nextLevel}'
      max-level='#{maxLevel}'>{{ item.label }}</a>"

    if categoryLevel == maxLevel
      children_list = ''
    else
      children_list = "<ul ng-repeat='item in item.children' class='subcategories'>
        <listnode
          item='item'
          category-level='#{nextLevel}'
          max-level='#{maxLevel}'>
        </listnode>
      </ul>"

    template = wrap_start + link + children_list + wrap_end

  return {
    restrict: 'E'
    scope:
      item: '='
    link: (scope, element, attrs) ->
      categoryLevel = parseInt attrs.categoryLevel
      maxLevel = parseInt attrs.maxLevel || 100

      template = get_template(categoryLevel, maxLevel)

      e = $compile(template)(scope)
      element.replaceWith(e)

      scope.user_clicks_item = (item) ->
        console.log item
  }
