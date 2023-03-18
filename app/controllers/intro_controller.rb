class IntroController < ApplicationController

  def show 
    @articles = Article.where(status: "OPEN").order(updated_at: :desc).first(5)
  end
end
  