class IntroController < ApplicationController

  def show 
    @articles = Article.first(5)
  end
end
  