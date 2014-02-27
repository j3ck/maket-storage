class VersionsController < ApplicationController
	load_and_authorize_resource except: [:create]
	before_action :set_version, only: [:show, :edit, :update, :destroy]
	before_filter :right_owner, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!

	def show
	end

	def create
		@version = Version.new(version_params)

		is_create = @version.save
		if is_create
			version_html = render_to_string( :partial => 'versions/version', :formats => [:html], :locals => { :version => @version } )
			form_html = render_to_string( :partial => 'versions/add_version',
                                      :formats => [:html],
                                      :locals => { :version => @version.project.versions.build } )
		else
			form_html = render_to_string( :partial => 'versions/add_version', :formats => [:html], :locals => { :version => @version } )
		end
		render :json => { :create_status => is_create, :form_html => form_html, :version_html => version_html }
	end

	def destroy
	    @version.destroy
	    respond_to do |format|
	      format.html { redirect_to @version.project }
	    end
  	end

	private
		def set_version
			@version = Version.find(params[:id])
		end
			
		def version_params
			params.require(:version).permit(:name, :project_id) 
		end

		def right_owner
      		@version = Version.find(params[:id])
      		unless current_user.role == "Administrator"
      			unless @version.project.user_id == current_user.id
	      			redirect_to(@version.project)
	      			flash[:error] = "Доступ запрещен."
      			end
    		end
    	end
end
