require 'net/http'

class PromptController < ApplicationController

    def prompt
        prompt = request.body.read
        uri = URI.parse("https://api.openai.com/v1/chat/completions")
        
        req = Net::HTTP::Post.new(uri)

        request_body = {
            "model": "gpt-3.5-turbo",
            "messages": [{
                "role": "user",
                "content": "prompt"
            }],
            "temperature": 0.7
        }
        req.body = request_body.to_json

        req["Content-Type"] = "application/json"
        req["Authorization"] = "Bearer #{ENV["PERSONAL_BLOG_KEY"]}" 
        http = Net::HTTP.new(uri.hostname, uri.port)
        http.use_ssl = true

        res = http.request(req)
        puts "\nreq: #{req.body}\n"
        puts "\nres: #{res.body}\n"

        return res
    end
end
