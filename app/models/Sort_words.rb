class SortWords
  def self.sort_words(words, sort)
    case sort
    when "alphabetical"
      words = words.sort
    when "length_asc"
      words = words.sort_by(&:length)
    when "length_desc"
      words = words.sort_by(&:length).reverse
    else
      words
    end
    words
  end
end
