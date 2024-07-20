class SearchesController < ApplicationController
  def tags
    @tags = SearchService.search_tags(params[:keyword])
    render json: { keyword: @tags }
  end

  def results
    @objects = SearchService.new(current_user).search_notes_and_prompts(search_params)
  end

  private

  def search_params
    params.permit(:keyword, :category, { tags: [] }, :type, :sort, :commit)
  end
end
