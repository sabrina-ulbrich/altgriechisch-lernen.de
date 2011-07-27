class Layouts::Sidebar < Minimal::Template
  include do
    def to_html
      div :id => :sidebar do
        div :id => :menu do
          search
          pages
          categories
          archive
        end
      end
    end

    protected

      def blog
        site.blogs.first
      end

      def search
        self << <<-html.html_safe
          <form method="get" id="searchform" action="http://google.de">
            <div>
              <input type="text" value="" name="s" id="s">
              <input type="submit" id="searchsubmit" value="Suchen">
            </div>
          </form>
        html
      end

      def pages
        h2 'Seiten'
        ul do
          site.pages.each do |page|
            li :class => 'page_item' do
              link_to page.name, page
            end
          end
        end
      end

      def pages
        h2 'Seiten'
        ul do
          site.pages.each do |page|
            li :class => 'page_item' do
              link_to page.name, page
            end
          end
        end
      end

      def categories
        h2 'Kategorien'
        ul do
          blog.categories.each do |category|
            li :class => 'cat-item' do
              link_to(category.name, url_for(:blog_id => blog, :category_id => category))
              self << "(#{category.categorizables.count})"
            end
          end
        end
      end

      def archive
        h2 'Archiv'
        ul do
          blog.archive.each do |month|
            li :class => 'archive-item' do
              link_to(l(month, :format => :archive), url_for(:blog_id => blog, :year => month.year, :month => month.month))
            end
          end
        end
      end
  end
end
