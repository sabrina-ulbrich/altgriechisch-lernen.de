require_dependency 'post'

Post.class_eval do
  def disqus_url
    uuid.split(' ').last.gsub(/\/$/, '') if uuid
  end

  def disqus_id
    uuid || "altgriechisch-lernen:post:#{id}"
  end
end


