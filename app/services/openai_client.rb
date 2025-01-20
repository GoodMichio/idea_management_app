require "openai"

class OpenAIClient
  def self.client
    @client ||= OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
  end
end
