class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end

  def index
  end

  def create
    req = JSON.parse(request.body.read)

    article = Article.create(title: req["title"], markdown: req["markdown"], status: "RENDERING")
    RenderBlogPostsJob.perform_async(article.id)
  end
end
