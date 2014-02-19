class MaketsController < ApplicationController
before_action :set_maket, only: [:edit, :update]

	def create
		@maket = Maket.new(maket_params)

		respond_to do |format|
			if @maket.save
				format.html { redirect_to @maket.version, notice: "Maket created successfull" }
			else
				format.html { redirect_to [@maket.version.project, @maket.version], notice: "Name is not valid" }
			end
		end
	end

	def show
		@maket = Maket.find_by_image_fingerprint(params[:id])
	end

	def edit
  	end

	def destroy
		@maket = Maket.find_by_image_fingerprint(params[:id])
		@maket.destroy
	    respond_to do |format|
	      format.html { redirect_to @maket.version }
	      format.json { head :no_content }
	    end
	end

	private
		def set_maket
			@maket = Maket.find(params[:id])
		end

		def maket_params
			params.require(:maket).permit(:name, :version_id, :image)
		end
end
