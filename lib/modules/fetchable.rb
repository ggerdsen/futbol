
module Fetchable
  def fetch_data(path, object)
    data = CSV.read(path, headers: true, header_converters: :symbol)
    data.map do |row|
      object.new(row)
    end
  end
end
