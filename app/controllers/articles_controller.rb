class ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id])
  end

  def index
  end

  def create
    req = request.body.read

    title = req.split("\n").first.strip().gsub(/[\#\*\`]/, '')

    article = Article.create(title: title, markdown: req, status: "RENDERING")
    RenderBlogPostsJob.perform_async(article.id)
  end
end
