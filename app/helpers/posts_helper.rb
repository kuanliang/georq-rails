module PostsHelper
  def render_post_content(post)
    #truncate(simple_format(post.content), :lenth => 200)
    simple_format(truncate(post.content), :lenth => 200)
  end
   def render_post_content_full(post)
    #truncate(simple_format(post.content), :lenth => 200)
    simple_format(post.content)
  end
end
