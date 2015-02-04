class MigrateRecipeYeastsToYeasts < ActiveRecord::Migration
  def up
    # if Rails.env.production?
    #   execute ""
    # else  
    #   execute "INSERT INTO yeasts(recipe_id, name, created_at, updated_at) SELECT id, yeast, date('now'), date('now') FROM recipes"
    # end
    Recipe.all.each do |recipe|
      yeast_name = recipe.yeast.blank? ? '' : recipe.yeast
      Yeast.create!(name: yeast_name, recipe: recipe, attenuation: 0.75)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
