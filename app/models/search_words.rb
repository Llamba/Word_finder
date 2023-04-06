class SearchWords
  def self.search(query, min_word_length, max_word_length, starts_with, ends_with, dont_include, word_typed_only)
    File.open("movies.txt", "r+") do |text|
      data = text.readlines.map { |line| line.downcase.chomp.split(/\s+/) }
      results = []

      if query && query.split.all? { |term| data.flatten.include?(term) }
        if word_typed_only == "true"
          results << query
          return results
        end
      end

      dont_include = dont_include.split(',') if dont_include
      min_word_length = min_word_length.to_i if min_word_length
      max_word_length = max_word_length.to_i if max_word_length

      parsed = query.split if query

      data.each do |section|
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
      results
    end
  end
end
