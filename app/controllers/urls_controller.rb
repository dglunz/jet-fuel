class UrlsController < ApplicationController
  def create
    @url = Url.find_by(original: params[:url][:original])
    @url = Url.new(url_params) if @url.blank?
    respond_to do |format|                                                           
      @url.save ? format.js : format.js { render "failed" }
    end
  end

  def show
    url = Url.find(params[:id])
    redirect_to url.original 
  end

  private

  def url_params
    params.require(:url).permit(:original)
  end
end
