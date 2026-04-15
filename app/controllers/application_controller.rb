class ApplicationController < ActionController::API
	before_action :authorize_request
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

	def authorize_request
		header = request.headers['Authorization']
		token = header.split('').last if header

		decoded = JsonWebToken.decode(token)

		if decoded
			@current_user = User.find(decoded[:user_id])
		else
			render json: {error: 'Unauthorized' }, status: :unauthorized
		end
	end

	private

	def record_not_found
		render json: {error: "Not found"}, status: :not_found
	end
end
