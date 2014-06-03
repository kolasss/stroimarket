module NavigationHelper
  def current_path
    request.path
  end

  def current_path? path, root = nil
    if path == (root or root_path)
      current_path == path
    else
      current_path.start_with?(path)
    end
  end

  def nav_item title, path = nil, options = nil, &blk
    path, options = title, path if block_given?

    options ||= {}
    options.reverse_merge!(wrapper: :li, root: nil)

    wrapper = options.delete(:wrapper)
    is_active = current_path?(path, options.delete(:root))

    content_tag(wrapper, class: (:active if is_active)) do
      if block_given?
        link_to(path, options, &blk)
      else
        link_to(title, path, options)
      end
    end
  end

  # def breadcrumbs links = {}
  #   links = links.map do |title, path|
  #     "<span>#{link_to title, path}</span>"
  #   end

  #   raw %{
  #     <nav class="page-breadcrumbs">
  #       <span>#{link_to t('nav.main'), root_path}</span>
  #       #{links.join}
  #     </nav>
  #   }
  # end
end
