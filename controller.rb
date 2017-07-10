require_relative 'view'
require_relative 'recipe'
require_relative 'parser'

class Controller

  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    list_all
  end

  def create
    # Perguntar o nome
    name = @view.ask_for_recipe_name
    # Perguntar a descrição
    description = @view.ask_for_recipe_description

    # Instaciar a recipe
    recipe = Recipe.new(name, description)

    # Adiciona no cookbook
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # Mostrar todas as receitas
    list_all
    # Perguntar o index da recipe
    index = @view.ask_for_index
    # cookbook exclui pelo index
    @cookbook.remove_recipe(index)
  end

  def import
    # Perguntar o ingrediente
    ingredient = @view.ask_for_ingredient
    # Mostrar a lista com os nomes das receitas

    options = Parser.search(ingredient)

    @view.list_options(options)
    # Perguntar o index da receita
    index = @view.pick_option
    # Fazer o scrap da receita

    recipe = Parser.scrap(options[index][:link], options[index][:name])

    # Instanciar a receita com os dados do scrap
    # Adicionar a receita no cookbook
    @cookbook.add_recipe(recipe)
  end

  def mark_as_done
    list_all
    index = @view.ask_for_index
    recipe = @cookbook.find(index)
    recipe.mark_as_done
    @cookbook.save
  end

  private

  def list_all
    #Pegar todas as receitas
    recipes = @cookbook.all
    #View mostra todas as receitas
    @view.display(recipes)
  end




end