class Posts::Show < Minimal::Template
  include do
    def to_html
      navigation
      div :class => 'post' do
        h2 resource.title
        metadata
        self << resource.body.html_safe
      end
      disqus
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

      def disqus
        div '', :id => 'disqus_thread'
        script <<-js, :type => 'text/javascript'
          var disqus_url = '#{post.disqus_url}';
          var disqus_identifier = '#{post.disqus_id}';
          var disqus_shortname = 'altgriechisch-lernen';
          var disqus_title = '#{post.title}'
          var disqus_developer = 1;

          (function() {
              var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
              dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
              (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
          })();
        js
      end
  end
end
