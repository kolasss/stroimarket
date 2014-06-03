module AdminHelper
  def render_sortable_tree collection
    html = ''

    collection.each do |item|
      image  = image_tag(item.cover.thumb, class: 'img-thumbnail') if item.try(:cover) && item.cover.present?
      link   = link_to item.title.to_s, polymorphic_path([:admin, item]), class: 'item_title'
      edit   = icon_link :pencil, edit_polymorphic_path([:admin, item])
      delete = icon_link :times, polymorphic_path([:admin, item]), method: :delete, data: { confirm: t(:confirm_deletion) }

      subtree = content_tag :ol, class: 'sortable_tree', data: { id: raw(item._id) } do
        render_sortable_tree item.children if item.children.present?
      end

      html += %{<li data-id="#{item._id}" class="list_node">
        <div class="node_item">
          <span class="sorting-handle">
            <i class="fa fa-arrows-alt"></i>
          </span>
          #{image}
          #{link}
          <div class="control-links">
            #{edit}
            #{delete}
          </div>
        </div>
        #{subtree}
      </li>}
    end

    html.html_safe
  end
end
