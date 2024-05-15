import Config
   config :crawly,
   closespider_timeout: 10,
   concurrent_requests_per_domain: 8,
   closespider_itemcount: 100,
  #  output_format: "csv",
   middlewares: [
     Crawly.Middlewares.DomainFilter,
     Crawly.Middlewares.UniqueRequest,
     {Crawly.Middlewares.UserAgent, user_agents: ["Crawly Bot","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"]}
   ],
   pipelines: [
     {Crawly.Pipelines.Validate, fields: [:title, :url, :price, :image, :vendor]},
     {Crawly.Pipelines.DuplicatesFilter, item_id: :title},
    {Crawly.Pipelines.CSVEncoder, fields: [:title, :url, :price, :image, :vendor]},
    {Crawly.Pipelines.WriteToFile, extension: "csv", folder: File.cwd!() <> "/data",include_timestamp: false, headers: [:title, :url, :price, :image, :vendor]}
  #  {Crawly.Pipelines.WriteToFile, extension: "csv", folder: "data/",include_timestamp: false, }
   ]
  