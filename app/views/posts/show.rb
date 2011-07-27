class Posts::Show < Minimal::Template
  include do
    def to_html
      navigation
      div :class => 'post' do
        h2 { link_to(resource.title, resources, :class => 'entry-title', :rel => 'bookmark') }
        metadata
        self << resource.body.html_safe
      end
    end

    protected

      def previous_post
        @previous ||= post.previous
      end

      def next_post
        @next ||= post.next
      end

      def navigation
        div :class => :navigation do
          div :class => :alignleft do
            '&laquo; '.html_safe + capture { link_to(previous_post.title, [blog, previous_post]) }
          end if previous_post
          div :class => :alignright do
            capture { link_to(next_post.title, [blog, next_post]) } + ' &raquo;'.html_safe
          end if next_post
        end
      end

      def metadata
        p :class => 'postmetadata' do
          self << "Veröffentlicht in: #{capture { categories_links.join(', ') } } am: #{l(post.published_at, :format => :post)}".html_safe
        end
      end

      def categories_links
        post.categories.map do |category|
          link_to(category.name, url_for(:blog_id => blog, :category_id => category), :rel => 'category tag')
        end
      end
  end
end
