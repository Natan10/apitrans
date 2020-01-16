module Translate
    KEY = 'trnsl.1.1.20200115T233426Z.637905839edf4505.abb7ef7eacc05b7b1649c0efcf42141ff401ed31'
    class Trans
        def initialize(params)
          @word = params["word"]
        end

        def call
            return "Digite uma Palavra válida" if @word == nil or @word == Integer
            req = HTTP.post("https://translate.yandex.net/api/v1.5/tr.json/translate?key=#{KEY}&text='home'&lang=en-ja")
            if req.code == 200
                result = JSON::parse(result.body)['text'][0]
            elsif req.code == 422
                'O texto não pode ser traduzido.'
            end
        end
    end
end