class IntroController < ApplicationController

  def is_positive?(num)
    Integer(num) > 0 rescue false
  end

  def show 
    requested_page = (params.key?("page") && is_positive?(params["page"])) ? params["page"].to_i : 1
    count_per_page = (params.key?("count_per_page") && is_positive?(params["count_per_page"])) ? params["count_per_page"].to_i : 10
    article_count = Article.where(status: "OPEN").count
    @num_pages = (article_count.to_f / count_per_page).ceil
    @page = (requested_page > @num_pages) ? @num_pages : requested_page
    page_offset = (@page - 1) * count_per_page
    @articles = Article.where(status: "OPEN").order(updated_at: :desc).limit(count_per_page).offset(page_offset)
  end
end
  