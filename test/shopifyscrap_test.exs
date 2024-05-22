defmodule ShopifyscrapTest do
  use ExUnit.Case
  doctest ShopifySpider

  describe "testing the spider" do

    test " spider base url" do
      assert ShopifySpider.base_url() =~ ~r(^https:\/\/.*/)
    end

    test " spider initialisation" do
      regex = ~r(^https:\/\/.*/)
      start_urls = ShopifySpider.init()[:start_urls]

      assert Enum.all?(start_urls, fn url -> Regex.match?(regex, url) end)
    end


      test "checking response and fetching items" do

        url = "https://www.goodeeworld.com/products.json"

        response = HTTPoison.get!(url)

        items = ShopifySpider.parse_item(response)

        assert is_struct(items)
        assert items != %Crawly.ParsedItem{items: [] ,requests: []}

      end


  end
end
