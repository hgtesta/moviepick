class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string "title"
      t.decimal "rating"
      t.integer "votes"
      t.string "votes_distribution"
    end
  end
end
