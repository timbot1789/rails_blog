class RenderBlogPostsJob
  include Sidekiq::Job

  def perform(*args)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    article = Article.find_by_id(args.first)
    article.update(body: markdown.render(article.markdown))
    article.update(status: "OPEN")
  end
end
