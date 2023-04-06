class SearchController < ApplicationController
    def index
        query = params[:query]
        @min_word_length, @max_word_length, @starts_with, @ends_with, @dont_include, @word_typed_only =
          params.transform_values(&:presence).values_at(:min_word_length, :max_word_length, :starts_with, :ends_with, :dont_include, :word_typed_only)
        @results = SearchWords.search(query, @min_word_length, @max_word_length, @starts_with, @ends_with, @dont_include, @word_typed_only)
    end
    def search
        @query = params[:query]
        @min_word_length, @max_word_length, @starts_with, @ends_with, @dont_include, @word_typed_only =
          params.transform_values(&:presence).values_at(:min_word_length, :max_word_length, :starts_with, :ends_with, :dont_include, :word_typed_only)
        @results = SearchWords.search(@query, @min_word_length, @max_word_length, @starts_with, @ends_with, @dont_include, @word_typed_only)
    end
end
