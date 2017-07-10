require 'csv'

class Cookbook

  def initialize(csv_file)
    @csv_file = csv_file
    @recipes = []
    load
  end


  def add_recipe(recipe)
    @recipes << recipe
    save
  end

  def all
    @recipes
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save
  end

  def find(index)
    @recipes[index]
  end

  def save
    CSV.open(@csv_file, 'wb') do |csv|
      @recipes.each do |recipe|
        name = recipe.name
        description = recipe.description
        prep_time = recipe.prep_time
        done = recipe.done
        csv << [name, description, prep_time, done]
      end
    end
  end

  private

  def load
    CSV.foreach(@csv_file) do |row|
      name = row[0]
      description = row[1]
      prep_time = row[2]
      done = row[3] == "true"
      recipe = Recipe.new(name, description, prep_time, done)

      @recipes << recipe
    end
  end

end