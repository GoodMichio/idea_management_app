require_relative 'app/services/openai_client'

3.times do
 response = OpenAIClient.client.completions(
   parameters: {
     model: "gpt-3.5-turbo",
     messages: [ { role: "user", content: "AIアシスト付きアイデア管理アプリとは？" } ],
     max_tokens: 100
   }
 )
 puts response["choices"].first["text"]
rescue Faraday::TooManyRequestsError
 puts "レート制限に達しました。数分待機してから再試行してください。"
 sleep 300 # 5分待機
 retry # 再試行
end
