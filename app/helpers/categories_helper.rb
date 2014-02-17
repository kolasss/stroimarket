module CategoriesHelper
  def render_category_tree collection
    html = ''
    collection.each do |item|
      html += content_tag :li, class: 'list_node', data: { id: raw(item._id) } do
        inner_html = ''
        inner_html += content_tag :div, class: 'node_item' do
          inner_html = ''
          inner_html += content_tag :span, icon(:move), class: 'sorting-handle'
          name = (item.title.to_s + ' ' + item.position.to_s)
          inner_html += link_to name, admin_category_path(item), class: 'item_title'
          inner_html += content_tag :div, class: 'control-links' do
            inner_html = ''
            inner_html += icon_link :pencil, edit_admin_category_path(item)
            inner_html += icon_link :remove, admin_category_path(item), method: :delete, data: { confirm: t(:confirm_deletion) }
            inner_html.html_safe
          end
          inner_html.html_safe
        end
        inner_html += content_tag :ol, class: 'sortable_tree', data: { id: raw(item._id) } do
          render_category_tree item.children if item.children.present?
        end
        inner_html.html_safe
      end
    end
    html.html_safe
  end
end
