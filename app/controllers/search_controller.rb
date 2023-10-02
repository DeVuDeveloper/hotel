class SearchController < ApplicationController
  def search_results
    query = params[:query]
    if query.present?
      results = Room.search({
        query: {
          multi_match: {
            query: query,
            fields: ["name^3", "description"]
          }
        }
      })
      @rooms = results.to_a
    else
      @rooms = []
    end

    respond_to do |format|
      format.json { render json: @rooms }
    end
  end
end
