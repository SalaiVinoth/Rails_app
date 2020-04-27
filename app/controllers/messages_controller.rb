class MessagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_message, only: [:show, :edit, :update, :destroy]

  def index
    @messages = Message.all.order("created_at DESC")
  end

  def new
    @message = current_user.messages.build
  end

  def show
  end

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      redirect_to message_path
    else
      render 'edit'
    end
  end

  def upvote
    @message = Message.find(params[:id])
    @message.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @message = Message.find(params[:id])
    @message.downvote_from current_user
    redirect_to :back
  end

  def destroy
    @message.destroy
    redirect_to root_path
  end

  def profile
    @user = User.all
  end

  private

  def message_params
    params.require(:message).permit(:title,:description,:url)
  end

  def find_message
    @message = Message.find(params[:id])
  end

end
