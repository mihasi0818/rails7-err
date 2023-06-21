class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:create]

    def index
        if params[:search]
          @posts = Post.where('title LIKE ?', "%#{params[:search]}%")
        else
          @posts = Post.all
        end
        @pagy, @posts = pagy(@posts, items: 16)
      end
      
      def new
        @post = Post.new
      end
     
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end
  
def show
  @post = Post.find(params[:id])
end
def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
  @post = Post.find(params[:id])
  @post.destroy
  redirect_to posts_path, notice: "投稿が削除されました。"
end



private
def post_params
  params.require(:post).permit(:title, :content, :image)
end

end
