class AddYearAndYearPartToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :year, :integer
    add_column :movies, :year_part, :integer
  end
end
