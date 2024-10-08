defmodule ShopifySpider do
  @doc """
  Returns the base URL for the spider

  ### Example

  iex> ShopifySpider.base_url()
  "https://www.goodeeworld.com/"

  iex> ShopifySpider.init()
  [start_urls: ["https://goodfair.com/products.json","https://www.adoredvintage.com/products.json","https://www.goodeeworld.com/products.json"],]

  """

  use Crawly.Spider
  @impl Crawly.Spider
  def base_url(), do: "https://www.goodeeworld.com/"

  @impl Crawly.Spider
  def init() do
    IO.puts("Spider initialized")
    #  IO.gets("Press Enter to continue")
    [
      start_urls: [
        "https://goodfair.com/products.json",
        "https://www.adoredvintage.com/products.json",
        "https://www.goodeeworld.com/products.json"
      ]
    ]
  end

  @impl Crawly.Spider
  def parse_item(response) do
    IO.puts("Parsing item")
    #  IO.inspect(response.request_url)
    #  {:ok, document} = Floki.parse_document(response.body)

    headers = [
      %{
        title: "title",
        price: "price",
        description: "description",
        image: "image",
        vendor: "vendor",
        url: "url"
      }
    ]

    json = Jason.decode!(response.body)
    # IO.inspect(json)

    items =
      headers ++
        Enum.map(json["products"], fn product ->
          %{
            title: product["title"],
            price: product["variants"] |> Enum.map(fn x -> x["price"] end) |> Enum.at(0),
            description: product["body_html"] |> Floki.text(),
            image: product["images"] |> Enum.map(fn x -> x["src"] end) |> Enum.at(0),
            vendor: product["vendor"],
            url: response.request_url
          }
        end)

    # IO.inspect(items)

    %Crawly.ParsedItem{items: items}
  end
end
