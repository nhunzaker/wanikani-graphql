use Mix.Config

config :wanikani, :api_host, "api.wanikani.com"
config :wanikani, :api_version, "v2"
config :wanikani, :api_revision, "20170710"

import_config "#{Mix.env()}.exs"
