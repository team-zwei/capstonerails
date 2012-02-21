class HelpController < ApplicationController
	skip_before_filter :require_login
	
	def index
	end
end
