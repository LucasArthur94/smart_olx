class AdsController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_action :set_ad, only: [:destroy]

  # GET /ads
  # GET /ads.json
  def index
    @ads = Ad.order(sort_column + " " + sort_direction).page(params[:page])
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_url, notice: 'Ad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ad
    @ad = Ad.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ad_params
    params.require(:ad).permit(:title, :olx_id, :is_new, :page)
  end

  def sort_column
    Ad.column_names.include?(params[:sort]) ? params[:sort] : "price"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
