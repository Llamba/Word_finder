class SearchController < ApplicationController
    def index
        query = params[:q]
        @min_word_length = params[:min_word_length]
        @max_word_length = params[:max_word_length]
        @starts_with = params[:starts_with]
        @ends_with = params[:ends_with]
        @dont_include = params[:dont_include]
        @results = search_words(query, @min_word_length, @max_word_length, @starts_with, @ends_with, @dont_include)
      end
    def search
        @query = params[:query]
        @min_word_length = params[:min_word_length]
        @max_word_length = params[:max_word_length]
        @starts_with = params[:starts_with]
        @ends_with = params[:ends_with]
        @dont_include = params[:dont_include]
        @results = search_words(@query, @min_word_length, @max_word_length, @starts_with, @ends_with, @dont_include)
      end
      private
    
      def search_words(search, min_word_length, max_word_length, starts_with, ends_with, dont_include)
        File.open("movies.txt", "r+") do |text|
          @results = []
          if min_word_length == ""
            min_word_length = nil
          end
          if max_word_length == ""
            max_word_length = nil
          end
          if starts_with == ""
            starts_with = nil
          end
          if ends_with == ""
            ends_with = nil
          end
          if dont_include.blank?
            dont_include = nil
          else
            dont_include = dont_include.split(',')
          end
          min_word_length = min_word_length.to_i if min_word_length
          max_word_length = max_word_length.to_i if max_word_length

          data = text.readlines.map { |line| line.downcase.chomp.split(/\s+/) }
          parsed = search.split if search
      
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
                    @results << word
                end
                end
            end
          end
        end
        @results
      end
    end