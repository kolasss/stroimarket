module AdminHelper
  def render_sortable_tree collection
    html = ''
    collection.each do |item|
      html += content_tag :li, class: 'list_node', data: { id: raw(item._id) } do
        li_html = ''
        li_html += content_tag :div, class: 'node_item' do
          item_html = ''
          item_html += content_tag :span, icon(:move), class: 'sorting-handle'

          item_html += image_tag(item.cover.thumb, class: 'img-thumbnail') if item.try(:cover) && item.cover.present?

          name = (item.title.to_s + ' ' + item.position.to_s + ' ' + item._id.to_s)
          name = item.title.to_s

          item_html += link_to name, polymorphic_path([:admin, item]), class: 'item_title'
          item_html += content_tag :div, class: 'control-links' do
            control_html = ''
            control_html += icon_link :pencil, edit_polymorphic_path([:admin, item])
            control_html += icon_link :remove, polymorphic_path([:admin, item]), method: :delete, data: { confirm: t(:confirm_deletion) }
            control_html.html_safe
          end
          item_html.html_safe
        end

        li_html += content_tag :ol, class: 'sortable_tree', data: { id: raw(item._id) } do
          render_sortable_tree item.children if item.children.present?
        end

        li_html.html_safe
      end
    end
    html.html_safe
  end
end
