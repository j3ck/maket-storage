class MaketsController < ApplicationController
before_action :set_maket, only: [:edit, :update] 

	def create
		@maket = Maket.new(maket_params)

		is_create = @maket.save
		if is_create
			maket_html = render_to_string( :partial => 'makets/maket', :formats => [:html], :locals => { :maket => @maket } )
			form_html = render_to_string( :partial => 'makets/add_maket',
                                      :formats => [:html],
                                      :locals => { :maket => @maket.version.makets.build } )
		else
			form_html = render_to_string( :partial => 'makets/add_maket', :formats => [:html], :locals => { :maket => @maket } )
		end
		render :json => { :create_status => is_create, :form_html => form_html, :maket_html => maket_html }
	end

	def show
		@maket = Maket.find_by_image_fingerprint(params[:id])
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
