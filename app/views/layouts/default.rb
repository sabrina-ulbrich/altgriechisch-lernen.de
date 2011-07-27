class Layouts::Default < Layouts::Base
  include do
    def title
      super(site.title)
    end

    def stylesheets(*names)
      stylesheet_link_tag 'styles'
    end

    def javascripts(*names)
    end

    def header
      div :id => :header do
        h1 capture { link_to(site.title, '/') }
        div 'Sprache &#8211; Philosophie &#8211; Geschichte'.html_safe, :class => :description
      end
      # hr
    end

    def body
      page
      footer
      disqus
    end

    def page
      div :id => :page do
        header
        div :id => :content, :class => params[:action] == 'index' ? :narrowcolumn : :widecolumn do
          content
        end
      render :partial => 'layouts/sidebar' if params[:action] == 'index'
      end
    end

    def footer
      div :id => :footer do
        p %(
          Copyright © 2007-2008 altgriechisch-lernen.de (siehe <a href="http://altgriechisch-lernen.de/impressum/">Impressum</a>)<br /><br />
          <a rel="license" href="http://creativecommons.org/licenses/by-sa/2.0/de/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/2.0/de/80x15.png" /></a>
        )
      end
    end

    def disqus
      script <<-js, :type => 'text/javascript' 
        var disqus_shortname = 'altgriechisch-lernen';
        var disqus_developer = 1;

        (function () {
            var s = document.createElement('script'); s.async = true;
            s.type = 'text/javascript';
            s.src = 'http://' + disqus_shortname + '.disqus.com/count.js';
            (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
        }());
      js
    end

    # def sidebar
    #   sidebar = capture { block.call(:sidebar) }
    #   div sidebar, :id => 'sidebar', :class => 'left' unless sidebar.blank?
    # end
  end
end
