class VersionsController < ApplicationController
	def create
		@version = Version.new(version_params)

		respond_to do |format|
			if @version.save
				format.html { redirect_to @version.project, notice: "Version created successfull" }
			else
				format.html { render 'versions/add_version', :version => @version }
			end
		end
	end

	private
		def version_params
			params.require(:version).permit(:name, :project_id) 
		end
end
