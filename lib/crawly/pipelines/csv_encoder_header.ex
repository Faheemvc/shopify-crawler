defmodule Crawly.Pipelines.CSVEncoderHeader do
  @moduledoc """
  Encodes a given item (map) into CSV with first items as headers for csv file. Does not flatten nested maps.
  ### Options
  If no fields are given, the item is dropped from the pipeline.
  - `:fields`, required: The fields to extract out from the scraped item. Falls back to the global config `:item`.

  ### Example Usage
    iex> item = %{my: "first", other: "second", ignore: "this_field"}
    iex> Crawly.Pipelines.CSVEncoder.run(item, %{}, fields: [:my, :other])
    {"first,second", %{}}
  """
  @behaviour Crawly.Pipeline
  require Logger

#editing current pipelines for accepting headers and writing to file
  @impl Crawly.Pipeline
  @spec run(map, map, fields: list(atom), headers: boolean()) ::
          {false, state :: map} | {csv_line :: String.t(), state :: map}


  def run(item, state, opts \\ [], headers) do
    # IO.puts("--------------  opts -----------------")
    # IO.inspect(opts)

    opts = Enum.into(opts, %{fields: nil})

    IO.puts("--------------  opts[:fields]  -----------------")

    IO.inspect( opts[:fields])


    if headers do
      IO.puts("-------------- headers -----------------")

      fields = opts[:fields]
      IO.inspect(fields)


      new_item = fields |> Enum.join("\"\,\"")

      IO.inspect(new_item)
      # headers = false

    {new_item, state}

    else

      case opts[:fields] do

        #first case condition to check if fields are nil or empty
        fields when fields in [nil, []] ->
          Logger.error(
            "Dropping item: #{inspect(item)}. Reason: No fields declared for CSVEncoder"
          )

          {false, state}

        #second case condition which return new items

        fields ->
             new_item =
                Enum.reduce(fields, "", fn
                  field, "" ->
                    "#{inspect(Map.get(item, field, ""))}"
                    # IO.inspect(Map.get(item, field, ""))

                  field, acc ->
                    # IO.puts(acc <> "," )#<> "#{inspect(Map.get(item, field, ""))}"#)
                    acc <> "," <> "#{inspect(Map.get(item, field, ""))}"
              end)


               {new_item, state}
        end


    end



  end
end
