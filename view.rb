class View

  def display(recipes)
    recipes.each_with_index do |recipe, index|
      done = recipe.done ? "[X]" : "[ ]"
      puts "---------------------------------------"
      puts "#{index + 1} - #{done} #{recipe.name}"
      puts "Preparation Time: #{recipe.prep_time}"
      puts "Description: #{recipe.description}"
      puts "---------------------------------------"
    end
  end

  def ask_for_recipe_name
    puts "Qual o nome da receita?"
    gets.chomp
  end

  def ask_for_recipe_description
    puts "Descreva essa receita"
    gets.chomp
  end

  def ask_for_index
    puts "Qual o index da receita?"
    gets.chomp.to_i - 1
  end

  def ask_for_ingredient
    puts "Which ingredient?"
    gets.chomp
  end

  def list_options(options)
    options.each_with_index do |option, index|
      puts "#{index + 1}. #{option[:name]}"
    end
  end

  def pick_option
    puts "pick a number to save"
    gets.chomp.to_i - 1
  end

end