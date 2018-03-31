class CommmentsController < ApplicationController
  before_action :set_commment, only: [:show, :update, :destroy]

  # GET /commments
  def index
    @commments = Commment.all

    render json: @commments
  end

  # GET /commments/1
  def show
    render json: @commment
  end

  # POST /commments
  def create
    @commment = Commment.new(commment_params)

    if @commment.save
      render json: @commment, status: :created, location: @commment
    else
      render json: @commment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /commments/1
  def update
    if @commment.update(commment_params)
      render json: @commment
    else
      render json: @commment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /commments/1
  def destroy
    @commment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commment
      @commment = Commment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def commment_params
      params.require(:commment).permit(:product_id, :user_id, :comment)
    end
end
