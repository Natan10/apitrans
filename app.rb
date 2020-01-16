require 'json'
require 'sinatra'
require 'http'

require './app/services/translate_service.rb'


class App < Sinatra::Base
    get "/" do
        "
        <html>
        <body>
            <h1>Página principal!!!</h1>
        </body>
        </html>
        "
    end

    post "/webhook" do
        puts 'chegou aki essa merda'
        request.body.rewind
        result = JSON.parse(request.body.read)["queryResult"]
        response = Translate::Trans.new(result["parameters"]).call()
    
        content_type :json, charset: 'utf-8'
            {
            "fulfillmentText": response,
            "payload": {
                "telegram": {
                "text": response,
                "parse_mode": "Markdown"
                }
            }
        }.to_json
    end
end

