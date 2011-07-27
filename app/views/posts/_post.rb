class Posts::Post < Minimal::Template
  include do
    def to_html
      div :class => 'entry' do
        h3 link_to_title
        content_tag :small, l(post.published_at, :format => :post, :locale => :de)
        div :class => :'entry-content' do
          self << truncate_html(post.body, :length => 700, :omission => " … #{link_to_more}").html_safe
        end
        metadata
      end
    end

    protected

      def link_to_title
        capture { link_to(post.title, [blog, post], :class => "entry-title", :rel => "bookmark") }
      end

      def link_to_more
        capture { link_to('Weiterlesen &raquo;'.html_safe, [blog, post], :class => "entry-title", :rel => "bookmark") }
      end

      def link_to_comments
        link_to('', url_for([blog, post]) + '#disqus_thread', :'data-disqus-identifier' => post.disqus_id, :class => "entry-title", :rel => "bookmark")
      end

      def metadata
        p :class => 'metadata' do
          self << "Kategorien: #{capture { categories_links.join(', ') } } |".html_safe
          link_to_comments
        end
      end

      def categories_links
        post.categories.map do |category|
          link_to(category.name, url_for(:blog_id => blog, :category_id => category), :rel => 'category tag')
        end
      end
  end
end

