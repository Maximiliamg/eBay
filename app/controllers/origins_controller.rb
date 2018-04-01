class OriginsController < ApplicationController
  before_action :set_origin, only: [:show, :update, :destroy]

  # GET /origins
  def index
    render_ok @current_user.origins
  end

  # GET /origins/1
  def show
    render_ok @origin
  end

  # POST /origins
  def create
    origin = Origin.new({user:@current_user}.merge origin_params)
    save_and_render origin
  end

  # PATCH/PUT /origins/1
  def update
    @origin.update_attributes origin_params
    save_and_render @origin
  end

  # DELETE /origins/1
  def destroy
    render_ok @origin.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_origin
      @origin = Origin.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def origin_params
      params.permit(:country, :state, :city, :postal_code, :address, :description)
    end
end
