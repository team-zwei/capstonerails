class HelpController < ApplicationController
	skip_before_filter :require_login
	skip_before_filter :require_admin
	
	def index
	end
end
