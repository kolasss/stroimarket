#= require jquery-sortable

adjustment = {}

$('ol.sortable_tree.tree_root').sortable
  handle: 'span.sorting-handle'

  onDrop: (item, targetContainer, _super) ->
    id = item.data('id')
    parent_id = targetContainer.el.data('id')
    # prev_id = null
    if item.prev('li.list_node').length != 0
      prev_id = item.prev('li.list_node').data('id')

    # console.log('id: ' + id)
    # console.log('container_id: ' + parent_id)
    # console.log('prev_id: ' + prev_id)

    $.ajax
      type:     'post'
      url:      '/admin/categories/update_position'
      data:
        id:        id
        parent_id: parent_id
        prev_id:   prev_id

    _super(item)

  # set item relative to cursor position
  onDragStart: ($item, container, _super) ->
    offset = $item.offset()
    pointer = container.rootGroup.pointer

    adjustment =
      left: pointer.left - offset.left
      top: pointer.top - offset.top

    _super($item, container)

  onDrag: ($item, position) ->
    $item.css
      left: position.left - adjustment.left,
      top: position.top - adjustment.top
