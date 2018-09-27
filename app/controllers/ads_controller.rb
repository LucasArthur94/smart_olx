class AdsController < ApplicationController
  before_action :set_ad, only: [:destroy]

  # GET /ads
  # GET /ads.json
  def index
    @ads = Ad.order(is_new: :desc, price: :asc, created_at: :desc)
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
      params.require(:ad).permit(:title, :olx_id, :is_new)
    end
end
