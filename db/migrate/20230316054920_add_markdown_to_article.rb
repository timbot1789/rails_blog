class AddMarkdownToArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :markdown, :text
  end
end
