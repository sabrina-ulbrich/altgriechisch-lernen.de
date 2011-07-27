# TODO move to adva-blog
PostsController.class_eval do
  def collection
    @_references << [blog, :posts] if @_references
    if params[:month]
      super.where("STRFTIME('%Y', contents.published_at) = ? AND STRFTIME('%m', contents.published_at) = ?", params[:year], params[:month].rjust(2, '0'))
    else
      super
    end
  end
end
