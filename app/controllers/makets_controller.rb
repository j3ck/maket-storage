class MaketsController < ApplicationController

	def create
		@maket = Maket.new(maket_params)
		if @maket.save

		else

		end
	end

	def show
		@maket = Maket.find(params[:id])
	end

	private
		def maket_params
			params.require(:maket).permit(:name, :version_id, :image)
		end
end
