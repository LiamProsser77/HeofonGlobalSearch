class HeofonSearch
  def initialize
    @pages = []
  end

  def add_page(title, url, content)
    @pages << {
      title: title,
      url: url,
      content: content.downcase
    }
  end

  def search(query)
    query = query.downcase

    results = @pages.map do |page|
      score = page[:content].scan(query).length

      if page[:title].downcase.include?(query)
        score += 10
      end

      page.merge(score: score)
    end

    results
      .select { |page| page[:score] > 0 }
      .sort_by { |page| -page[:score] }
  end
end

# -------------------------
# Example
# -------------------------

search = HeofonSearch.new

search.add_page(
  "Ruby Programming",
  "https://example.com/ruby",
  "Ruby is a fast programming language used for web development."
)

search.add_page(
  "Heofon Search",
  "https://heofon.com",
  "Heofon Search is a privacy focused search engine with its own search technology."
)

search.add_page(
  "Cats",
  "https://example.com/cats",
  "Cats are cute animals."
)

puts "Search Results:\n\n"

search.search("search").each do |result|
  puts "#{result[:title]}"
  puts "#{result[:url]}"
  puts "Score: #{result[:score]}"
  puts "-" * 40
end
