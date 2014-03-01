module CategoriesHelper
  def render_category_tree collection
    html = ''

    collection.each do |item|
      link = link_to item.title.to_s, category_path(item), class: 'item_title'

      subtree = content_tag :ul, class: 'subcategories_tree' do
        render_category_tree item.children
      end if item.children.present?

      html += %{<li class="category_node">
        #{link}
        #{subtree}
      </li>}
    end

    html.html_safe
  end
end
