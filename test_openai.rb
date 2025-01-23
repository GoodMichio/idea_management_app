require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: "ヒトの未来はどうなりますか？" }],
    }
)

puts response.dig("choices", 0, "message", "content")
