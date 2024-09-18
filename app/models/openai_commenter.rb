# app/models/openai_commenter.rb
class OpenaiCommenter
  def self.call(prompt)
    new(prompt).call
  end

  def initialize(prompt)
    @prompt = prompt
  end

  URL = "https://api.openai.com/v1/completions"

  def call
    json = ApiClient.new(URL, headers, body).post
    Rails.logger.debug "🔥:#{json}"
    json["choices"].first["text"]
  rescue NoMethodError
    "I'm sorry, but I cannot give a response based on the information provided."
  end

  private

  def headers
    {
      "Content-Type": "application/json",
      "Authorization": ["Bearer", ""].join(" ")
    }
  end

  def body
    {
      model: "gpt-3.5-turbo-instruct",
      prompt: @prompt,
      max_tokens: 100,
      temperature: 0
    }
  end
end