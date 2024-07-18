class SearchesController < ApplicationController
  def tags
    @tags = SearchService.search_tags(params[:keyword])
    render json: { keyword: @tags }
  end

  def results
    search_results = SearchService.new(current_user).search_notes_and_prompts(search_params)
    @notes = search_results[:notes]
    @prompts = search_results[:prompts]
    @objects = (@notes + @prompts)
  end

  private

  def search_params
    params.permit(:keyword, :category, { tags: [] }, :type, :sort, :commit)
  end
end
