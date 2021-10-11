defmodule WaniKani.Schema.Scalars do
  use Absinthe.Schema.Notation

  scalar :datetime, name: "DateTime" do
    description("""
    The `DateTime` scalar type represents a date and time in the UTC
    timezone. The DateTime appears in a JSON response as an ISO8601 formatted
    string, including UTC timezone ("Z"). The parsed date and time string will
    be converted to UTC if there is an offset.
    """)

    serialize(fn a ->
      {:ok, date, _offset} = DateTime.from_iso8601(a)
      date
    end)

    parse(fn a ->
      DateTime.to_iso8601(a)
    end)
  end
end
