class IdeasController < ApplicationController
  require_relative "../services/openai_client" # openai_client.rbのclass OpenAIClientを読み込む


  def index
    @ideas = Idea.all # すべてのアイデアを取得して'@ideas'に格納
  end

  def new_entry_manual
    @idea = Idea.new
  end

  def new_entry_auto
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

  def create_auto
    title = params[:title] #フォームのタイトル取得

    #AIからの提案を取得
    response = OpenAIClient.client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [{ role: "user", content: "入力されたタイトルでアイデアを提案してください。500文字以内で表現してください。長すぎる場合は要約してください。: #{title}" }],
        max_tokens: 1000
      }
    )

    suggestion = response.dig("choices", 0, "message", "content") || "AI提案が取得できませんでした"

    # DBに保存する
    @idea = Idea.new(title: title, description: suggestion)

    if @idea.save
      redirect_to ideas_path, notice: "AIの提案を元にアイデアを作成しました"
    else
      flash[:alert] = "アイデアの作成に失敗しました"
      render :new_entry_auto
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
