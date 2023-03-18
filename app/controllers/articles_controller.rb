class ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id])
  end

  def index
  end

  def create
    req = request.body.read
    arr = req.split("\n")
    title = arr.shift.strip().gsub(/[\#\*\`]/, '')
    body = arr.join("\n").strip()
    article = Article.create(title: title, markdown: body, status: "RENDERING")
    RenderBlogPostsJob.perform_async(article.id)
  end

  def update
    article = Article.find(params[:id])
    req = request.body.read
    arr = req.split("\n")
    title = arr.shift.strip().gsub(/[\#\*\`]/, '')
    body = arr.join("\n").strip()

    article.update(title: title, markdown: body, status: "RENDERING")
    RenderBlogPostsJob.perform_async(article.id)
  end
end
