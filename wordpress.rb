$KCODE = 'UTF8'

require 'rubygems'
require 'nokogiri'
require 'action_view'
require 'simple_slugs'
require 'fileutils'
require 'ya2yaml'


transliterations = {
  :'ä' => 'ae',
  :'ö' => 'oe',
  :'ü' => 'ue',
  :'Ä' => 'Ae',
  :'Ö' => 'Oe',
  :'Ü' => 'Ue',
  :'ß' => 'ss',
}

I18n.default_locale = :de
I18n.locale = :de
I18n.backend.store_translations(:de, :i18n => { :transliterate => { :rule => transliterations } })

class Page
  include ::ActionView::Helpers::TagHelper
  include ::ActionView::Helpers::TextHelper

  attr_reader :node

  def initialize(node)
    @node = node
  end

  def title
    node.xpath("title").text
  end

  def content
    node.xpath("content:encoded").text.gsub(%r(http://altgriechisch-lernen.de/wp-content/uploads/\d*/\d*), '/images/contents')
  end

  def creator
    node.xpath("dc:creator").text
  end

  def created_at
    DateTime.parse(node.xpath("wp:post_date").text)
  end

  def id
    node.xpath("wp:post_id").text.to_i
  end

  def parent_id
    id = node.xpath("wp:post_parent").text.to_i
    id == 0 ? nil : id
  end

  def url
    node.xpath("link").text
  end

  def status
    node.xpath("wp:status").text
  end

  def draft?
    status != 'publish'
  end

  def published?
    !draft?
  end

  def slug
    SimpleSlugs::Slug.new(title).to_s
  end

  def path
    ['import', slug].join('/') + '.jekyll'
  end

  def to_jekyll
    <<-txt
---
name: #{title}
filter: markdown
---
#{content}
txt
  end
end

class Post < Page
  def categories
    node.xpath("category[@domain='category']").collect do |cat|
      cat.text
    end
  end

  def slug
    [created_at.month, created_at.day, super].join('-')
  end

  def path
    ['import', created_at.year, slug].join('/') + '.jekyll'
  end

  def disqus_uuid
    "#{id} #{url}/"
  end

  def to_jekyll
    <<-txt
---
title: #{title.inspect}
categories: #{categories.join(', ')}
filter: markdown
uuid: #{disqus_uuid.inspect}
---
#{content}
txt
  end
end

class Attachment
  attr_reader :node

  def initialize(node)
    @node = node
  end

  def title
    node.xpath("title").text
  end

  def description
    node.xpath("description").text
  end

  def file_name
    url.split('/').last
  end

  def post_date
    DateTime.parse node.xpath("wp:post_date").text
  end

  def url
    node.xpath("wp:attachment_url").text
  end

  def path
    url.gsub(%r(http://altgriechisch-lernen.de/wp-content/uploads/\d*/\d*), 'public/images/contents')
  end

  def image?
    url.match /\.(png|jpg|jpeg|gif)$/
  end
end

doc = Nokogiri::XML(File.open('wordpress.2011-07-25.xml'))
doc.xpath("//item[wp:post_type='page']").each do |node|
  item = Page.new(node)
  FileUtils.mkdir_p(File.dirname(item.path))
  puts "write page #{item.path}"
  File.open(item.path, 'w+') { |f| f.write(item.to_jekyll) }
end

doc.xpath("//item[wp:post_type='post']").each do |node|
  item = Post.new(node)
  FileUtils.mkdir_p(File.dirname(item.path))
  puts "write post #{item.path}"
  File.open(item.path, 'w+') { |f| f.write(item.to_jekyll) }
end

doc.xpath("//item[wp:post_type='attachment']").each do |node|
  item = Attachment.new(node)
  next unless item.image?
  puts "$ curl --create-dirs -s -o #{item.path} #{item.url}"
  `curl --create-dirs -o #{item.path} #{item.url}`
  # File.open(item.path, 'w+') { |f| f.write(item.to_jekyll) }
end
