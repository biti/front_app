class RegionsController < ApplicationController
  def index
    region = Region.find_by_id(params[:id])
    render(:json => region && region.children.map { | r | { id: r.id, title: r.title } })
  end
end
