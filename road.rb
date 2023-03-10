# frozen_string_literal: true

class Road
  attr_accessor  :id , :name , :longueur , :width

  def initialize
  end

  def set_id(id)
    self.id = id.to_i
  end

  def set_name(name)
    self.name = name
  end

  def set_longueur(longueur)
    self.longueur = longueur.to_f
  end

  def set_width(width)
    self.width = width.to_f
  end


  def self.allRoad(connection)
    query = "select * from route_national order by name asc"
    data = connection.exec(query)
    result = []
    data.each do |row|
      temp_road = Road.new()
      temp_road.set_id(row['id'])
      temp_road.set_name(row['name'])
      temp_road.set_longueur(row['longueur'])
      temp_road.set_width(row['width'])
      result<<temp_road
    end
    return result
  end

  def self.road_list(query,conn)
    puts query
    data = conn.exec(query)
    result = []
    i = 0
    data.each do |row|
      temp_road = Road.new()
      temp_road.set_id(row['id'])
      temp_road.set_name(row['name'])
      temp_road.set_longueur(row['longueur'])
      temp_road.set_width(row['width'])
      result[i] = temp_road
      i+=1
    end
    return result
  end

  def formula(connection)
    t = "select * from formule where idroute=%s"
    query = sprintf(t,self.id)
    data = connection.exec(query)
    array = []
    i = 0
    data.each do |row|
      array[i] = row['formule']
      i+=1
    end
    return array
  end

end
