require 'nokogiri'
require 'open-uri'
class Parser

  def self.search(ingredient)
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?s=#{ingredient}&type=all"

    user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
    html = Nokogiri::HTML(open(url, "User-Agent" => user_agent))
    options = []
    html.search('.m_titre_resultat a').each do |element|
      name = element.text
      link = element.attribute('href').value
      options << {name: name, link: link}
    end
    options
  end

  def self.scrap(link, name)
    user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
    html = Nokogiri::HTML(open("http://www.letscookfrench.com#{link}", "User-Agent" => user_agent))
    description = html.search('.m_content_recette_todo').text.gsub("\r\n", "").strip

    prep_time = html.search('.preptime').text + "minutes"

    Recipe.new(name, description, prep_time)
  end
end