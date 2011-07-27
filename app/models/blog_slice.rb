Blog.class_eval do
  def archive
    # TODO optimize and move to adva-blog
    posts.order(:created_at).map { |post| Date.new(post.published_at.year, post.published_at.month, 1) }.uniq
  end
end

