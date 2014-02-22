#= require jquery-sortable

init_sortable = (target_list, item_type) ->
  adjustment = {}

  $(target_list).sortable
    handle: 'span.sorting-handle'

    onDrop: (item, targetContainer, _super) ->
      url = '/admin/' + item_type + '/update_position'
      id = item.data('id')
      parent_id = targetContainer.el.data('id')
      if item.prev('li.list_node').length != 0
        prev_id = item.prev('li.list_node').data('id')

      # console.log('id: ' + id)
      # console.log('parent_id: ' + parent_id)
      # console.log('prev_id: ' + prev_id)

      $.ajax
        type:     'post'
        url:      url
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


init_sortable('#categories_root', 'categories')

init_sortable('#articles_root', 'articles')
