module CategoriesHelper
  def render_category_tree type, collection, name, checked_id, object_id=nil, disabled=false
    html = "<label>Категории</label><div class='row category_tree' object_id='#{object_id}'>"

    collection.each do |item|
      if item.children.present?
        subtree = '<i class="fa fa-angle-down"></i>'
        subtree += render_subcats type, item.children, name, checked_id, disabled
      else
        subtree = ''
      end

      checked = item_is_checked?(type, item.id, checked_id)

      html += %{<div class="col-md-4">
        <div class="#{type}">
          <label>
            <input type="#{type}" name="#{name}" id="#{item.id}-cat" value="#{item.id}" #{checked} #{'disabled' if disabled}>
            #{item.title}
          </label>
          #{subtree}
        </div>
      </div>}
    end

    html += '</div>'
    html.html_safe
  end

  def render_subcats type, collection, name, checked_id, disabled=false
    html = '<ul>'

    collection.each do |item|
      subtree = render_subcats type, item.children, name, checked_id, disabled if item.children.present?

      checked = item_is_checked?(type, item.id, checked_id)

      html += %{<li class="#{type}">
        <label>
          <input type="#{type}" name="#{name}" id="#{item.id}-cat" value="#{item.id}" #{checked} #{'disabled' if disabled}>
          #{item.title}
        </label>
        #{subtree}
      </li>}
    end

    html += '</ul>'
    html.html_safe
  end

  def item_is_checked? type, item_id, checked_id
    if (type == 'radio' and item_id == checked_id) or (type == 'checkbox' and checked_id.include? item_id)
      return 'checked'
    else
      return nil
    end
  end

end
