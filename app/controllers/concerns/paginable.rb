module Paginable
  protected

  def current_page
    (params[:page] || 1).to_i
  end

  def per_page
    (params[:per_page] || 10).to_i
  end

  def get_links_serializer_options links_paths, collection
    {
      links: {
        first: send(links_paths, page: 1),
        last: send(links_paths, page: collection.pages),
        prev: send(links_paths, page: collection.prev),
        next: send(links_paths, page: collection.next)
      }
    }
  end
end