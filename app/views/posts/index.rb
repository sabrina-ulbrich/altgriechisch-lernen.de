class Posts::Index < Minimal::Template
  include do
    def to_html
      title
      render :partial => 'post', :collection => collection[0, 15]
    end
  end
end
