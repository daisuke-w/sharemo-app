class SearchesController < ApplicationController
  def tags
    @tags = SearchTagsService.search(params[:keyword])
    render json: { keyword: @tags }
  end
end
