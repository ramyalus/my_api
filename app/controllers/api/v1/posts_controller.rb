class Api::V1::PostsController < ApplicationController
	before_action :set_action, only: [:show, :update, :destroy]

	def index
		posts = @current_user.posts 
		render json: posts
	end

	def show
		render json: @post
	end

	def create
		post = @current_user.posts.new(post_params)
		if post.save 
			render json: post, status: :created
		else
			render json: {errors: post.errors}, status: :unprocessable_entity
		end
	end

	def update
		if @post.update(post_params) 
			render json: @post
		else
			render json: {errors: @post.errors}
		end
	end
  
  def destroy
  	@post.destroy
  	head :no_content
  end

	private 
	def set_action
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :body)
	end
end
