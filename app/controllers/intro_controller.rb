class IntroController < ApplicationController

  def show 
    @articles = Article.where(status: "OPEN").last(5)
  end
end
  