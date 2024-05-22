defmodule JsonManual do
  def json_item() do
    IO.puts("Parsing json item")

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

    # IO.inspect(File.cwd!())
    # File.exists?("lib/manual/product.json")
    {:ok, file} = File.read("lib/manual/product.json")
    # {:ok, json} = Jason.decode(file)
    {:ok, json} = Jason.decode(file)
    # IO.puts("***************************")
    # IO.inspect(json)
    # IO.puts("-----------------")
    items =
      headers ++
        Enum.map(json["products"], fn product ->
          %{
            title: product["title"],
            price: product["variants"] |> Enum.map(fn x -> x["price"] end) |> Enum.at(0),
            description: product["body_html"] |> Floki.text(),
            image: product["images"] |> Enum.map(fn x -> x["src"] end) |> Enum.at(0),
            vendor: product["vendor"]
            # url: response.request_url
          }
        end)

    IO.inspect(items)

    IO.puts("-----------------")
  end
end

# import JsonManual
# json_item()
