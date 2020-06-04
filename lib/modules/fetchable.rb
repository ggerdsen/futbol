
module Fetchable
  def fetch_data(path, object)
    data = CSV.read(path, headers: true, header_converters: :symbol)
    data.map do |row|
      object.new(row)
    end
  end

  def group_by_collection(array_collection, object_method)
    array_collection.group_by  do |game_team|
       game_team.send(object_method)
    end
  end  
end
