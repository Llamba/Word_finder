class SearchController < ApplicationController
    def index
        @query = params[:query]
        @sort = params[:sort]
        @min_word_length, @max_word_length, @starts_with, @ends_with, @dont_include, @word_typed_only =
          params.transform_values(&:presence).values_at(:min_word_length, :max_word_length, :starts_with, :ends_with, :dont_include, :word_typed_only)
        @min_word_length = @min_word_length.to_i if @min_word_length
        @max_word_length = @max_word_length.to_i if @max_word_length
        @dont_include = @dont_include.split(',') if @dont_include
        @word_typed_only = @word_typed_only == "true"
        @results = SearchWords.search(query: @query, min_word_length: @min_word_length, max_word_length: @max_word_length, starts_with: @starts_with, ends_with: @ends_with, dont_include: @dont_include, word_typed_only: @word_typed_only, sortby: @sort)
    end
    def search
        @query = params[:query]
        @sort = params[:sort]
        @min_word_length, @max_word_length, @starts_with, @ends_with, @dont_include, @word_typed_only =
          params.transform_values(&:presence).values_at(:min_word_length, :max_word_length, :starts_with, :ends_with, :dont_include, :word_typed_only)
        @min_word_length = @min_word_length.to_i if @min_word_length
        @max_word_length = @max_word_length.to_i if @max_word_length
        @dont_include = @dont_include.split(',') if @dont_include
        @word_typed_only = @word_typed_only == "true"
        @results = SearchWords.search(query: @query, min_word_length: @min_word_length, max_word_length: @max_word_length, starts_with: @starts_with, ends_with: @ends_with, dont_include: @dont_include, word_typed_only: @word_typed_only, sortby: @sort)
    end
end
