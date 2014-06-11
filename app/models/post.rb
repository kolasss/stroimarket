class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Content
  include PostFiles

  slug :title, history: true
end
