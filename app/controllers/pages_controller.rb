class PagesController < ApplicationController
  def home
    @url = Url.new
    @urls = Url.all
  end
end
