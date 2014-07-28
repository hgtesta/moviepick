class AddMoviesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :movie_ids, :string, array:true, default: []
  end
end
