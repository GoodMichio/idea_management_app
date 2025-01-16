class IdeasController < ApplicationController
  def index
    @ideas = Idea.all # すべてのアイデアを取得して'@ideas'に格納
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)
    if @idea.save
      redirect_to ideas_path, notice: "アイデアを作成しました"
    else
      render :new
    end
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def update
    @idea = Idea.find(params[:id])
    if @idea.update(idea_params)
      redirect_to ideas_path, notice: "アイデアを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def confirm_delete
    @idea = Idea.find(params[:id])
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    redirect_to ideas_path, notice: "アイデアを削除しました"
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description)
  end
end
