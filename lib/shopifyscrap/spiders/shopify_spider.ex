defmodule ShopifySpider do
  
  use Crawly.Spider
   @impl Crawly.Spider
   def base_url(), do: "https://www.goodeeworld.com/"

   @impl Crawly.Spider
   def init() do
     IO.puts("Spider initialized")
    [start_urls: ["https://www.goodeeworld.com/collections/gifts","https://www.goodeeworld.com/collections/household"],] #"https://www.goodeeworld.com/collections/household"
   end
   
   @impl Crawly.Spider
   def parse_item(response) do
     IO.puts("Parsing item")
     {:ok, document} = Floki.parse_document(response.body)
     

    

    items =
      document
      |> Floki.find(".product-block .block-inner .block-inner-inner")
      |> Enum.map(fn x ->
        %{
          title: Floki.find(x, " .product-info .inner .product-block__title") |> Floki.text(),
          vendor: Floki.find(x, ".product-info .inner .vendor") |> Floki.text(),
          price: Floki.find(x, ".product-info .inner .product-price .product-price__item ") |> Floki.text(),
          image: Floki.find(x, ".image-cont .image-label-wrap .product-block__image  img ") |> Floki.attribute("src") |> Floki.text(),
          url: response.request_url
        }
      end)

     
    #  next_requests =
    #    document
    #    |> Floki.find(".next a")
    #    |> Floki.attribute("href")
    #    |> Enum.map(fn url ->
    #      Crawly.Utils.build_absolute_url(url, response.request.url)
    #      |> Crawly.Utils.request_from_url()
    #    end)

     %Crawly.ParsedItem{items: items}
      
    end
    
end