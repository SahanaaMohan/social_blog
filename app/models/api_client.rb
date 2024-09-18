# app/models/api_client.rb
require "net/http"
class ApiClient
  def initialize(url, headers = {}, body = {})
    @url = URI(url)
    @headers = headers
    @body = body.to_json
  end

  def get; request(:get); end
  def post; request(:post); end
  def put; request(:put); end
  def delete; request(:delete); end

  private

  def request(method)
    request = build_request(method)
    http = Net::HTTP.new(@url.host, @url.port)
    http.use_ssl = @url.scheme == "https"
    response = http.request(request)
    handle_response(response)
  rescue Errno::ETIMEDOUT
    raise ApiError, "Operation timed out"
  end

  def build_request(method)
    request = case method
    when :get
      Net::HTTP::Get.new(@url, @headers)
    when :post
      Net::HTTP::Post.new(@url, @headers)
    when :put
      Net::HTTP::Put.new(@url, @headers)
    when :delete
      Net::HTTP::Delete.new(@url, @headers)
    end
    request.body = @body if [:post, :put].include?(method)
    request
  end

  def handle_response(response)
    return JSON.parse(response.body) if Net::HTTPSuccess

    error_message = "API request failed with code #{response.code}: #{response.message}"
    raise ApiError, error_message
  rescue JSON::ParserError
    raise ApiError, "Unable to parse JSON response"
  end
end

class ApiError < StandardError; end