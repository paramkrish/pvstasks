class ApplicationController < ActionController::Base
	  
=begin	  unless Rails.application.config.consider_all_requests_local
		rescue_from ActiveRecord::RecordNotFound, with: -> { render_404 } 
		rescue_from ActionController::UnknownController, with: -> { render_404  }
	    rescue_from ActionController::RoutingError, with: -> { render_404  }
		end

		protected

		def render_404
		  render file: 'public/404.html', status: :not_found
		end
=end
 end
