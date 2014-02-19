class VersionsController < ApplicationController
	before_action :set_version, only: [:show, :edit, :update, :destroy]
	before_filter :right_owner, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!

	def show
	end

	def edit
  	end

	def create
		@version = Version.new(version_params)

		respond_to do |format|
			if @version.save
				format.html { redirect_to @version.project, notice: "Version created successfull" }
			else
				format.html { redirect_to @version.project, notice: "Name is not valid" }
			end
		end
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
      		redirect_to(root_path) unless @version.project.user_id == current_user.id
    	end
end
