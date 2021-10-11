use Mix.Config

config :wanikani, :api_host, "api.wanikani.com"

import_config "#{Mix.env()}.exs"
