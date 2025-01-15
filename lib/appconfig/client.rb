# frozen_string_literal: true

module AppConfig
  # :nodoc:
  class Client
    SERVER = URI('http://localhost:2772')

    attr_reader :app_name, :env, :http

    def initialize(app_name:, env:)
      @app_name = app_name
      @env = env
      @http = Net::HTTP.new(SERVER.host, SERVER.port)
    end

    def get(name)
      res = http.get("/applications/#{app_name}/environments/#{env}/configurations/#{name}")
      raise res.body unless res.is_a?(Net::HTTPSuccess)

      JSON.parse(res.body, symbolize_names: true)
    rescue JSON::ParserError
      {}
    end
  end
end
