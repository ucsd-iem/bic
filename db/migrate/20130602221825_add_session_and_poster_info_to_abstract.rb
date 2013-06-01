class AddSessionAndPosterInfoToAbstract < ActiveRecord::Migration
  def change
    add_column :abstracts, :session, :string
    add_column :abstracts, :poster_number, :string
  end
end
