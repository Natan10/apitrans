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
        request.body.rewind
        result = JSON.parse(request.body.read)["queryResult"]
        if result["parameters"]['help'] == 'help'
            response = HelpTrans.call()
        else
            response = Translate::Trans.new(result["parameters"]).call()
        end
    
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

