class OrgsController < ApplicationController
  respond_to :json

  def index
    respond_with Org.all
  end
end
