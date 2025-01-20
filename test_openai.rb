require_relative 'app/services/openai_client'

response = OpenAIClient.client.chat(
  parameters: {
    model: "gpt-3.5-turbo",
    messages: [ { role: "user", content: "AIアシスト付きアイデア管理アプリとは？" } ],
    max_tokens: 50
  }
)
