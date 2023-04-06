class SearchWords
  def self.search(query, min_word_length, max_word_length, starts_with, ends_with, dont_include, word_typed_only)
    results = []
    dont_include = dont_include.split(',') if dont_include
    min_word_length = min_word_length.to_i if min_word_length
    max_word_length = max_word_length.to_i if max_word_length
    parsed = query.split if query
    File.foreach("movies.txt") do |line|
      section = line.downcase.chomp.split(/\s+/)
      if parsed
        if parsed.all? { |term| section.any? { |attr| attr.include?(term)}}
          add_word = true
          word = section[0]

          if max_word_length
            if word.size > max_word_length
              add_word = false
            end
          end

          if min_word_length
            if word.size < min_word_length
              add_word = false
            end
          end

          if ends_with
            unless word.end_with?(ends_with)
              add_word = false
            end
          end

          if starts_with
            unless word.start_with?(starts_with)
              add_word = false
            end
          end

          if dont_include
            dont_include.each do |current|
              if word.include?(current)
                add_word = false
                break
              end
            end
          end

          if add_word
            results << word
          end

        end
      end
    end

    if query && query.split.all? { |term| results.include?(term) } && word_typed_only == "true"
      results = [query]
    end
    results

  end
end