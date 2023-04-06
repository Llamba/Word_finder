class SearchController < ApplicationController
    def index
        query = params[:query]
        @min_word_length = params[:min_word_length].presence
        @max_word_length = params[:max_word_length].presence
        @starts_with = params[:starts_with].presence
        @ends_with = params[:ends_with].presence
        @dont_include = params[:dont_include].presence
        @word_typed_only = params[:word_typed_only].presence
        @results = SearchWords.search(query, @min_word_length, @max_word_length, @starts_with, @ends_with, @dont_include, @word_typed_only)
    end
    def search
        @query = params[:query]
        @min_word_length = params[:min_word_length].presence
        @max_word_length = params[:max_word_length].presence
        @starts_with = params[:starts_with].presence
        @ends_with = params[:ends_with].presence
        @dont_include = params[:dont_include].presence
        @word_typed_only = params[:word_typed_only].presence
        @results = SearchWords.search(@query, @min_word_length, @max_word_length, @starts_with, @ends_with, @dont_include, @word_typed_only)
    end
end
