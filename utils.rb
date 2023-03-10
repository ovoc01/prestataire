# frozen_string_literal: true

require_relative 'road'
require_relative 'entreprise'
class Utils
  def self.getSpecific_road(id,connection)
    query = sprintf("select * from route_national where %s =%s order by name asc",'id',id)
    data = connection.exec(query)
    temp_road = Object.new()
    data.each do |row|
      temp_road = Road.new()
      temp_road.set_id(row['id'])
      temp_road.set_name(row['name'])
      temp_road.set_longueur(row['longueur'])
      temp_road.set_width(row['width'])
    end
    return temp_road
  end

  def self.list_prestataire(id,con)
    road  = getSpecific_road(id,con)
    formula = road.formula(con)
    f = transform(formula[0],con)
    query = sprintf("select id,nom,prix,vitesse,employe,penalite,anciennete from info_prestataire order by (%s)/prix desc",f)
    return Entreprise.list_prestataire(query,con)
  end

  def self.checkRouteNational(formule)
    indices =  []
    word = 'RN'
    index = -1
    while index = formule.index(word,index+1)
      indices << getRn(index, formule)
    end
    return indices.uniq
  end

  def self.get_formula_rn(connection,rn)
    query = sprintf("select * from formule_rn where name = '%s'",rn)
    data = connection.exec(query)
    formula = ''
    data.each do |d|
      formula = d['formule']
    end
    return formula
  end

  def self.getRn(index,formula)
    return formula.slice(index,index+4)
  end

  def self.transform(formul,con)
    index_array = checkRouteNational(formul)
    index_array.each do |val|
      formul = formul.gsub(val,"("+transform(get_formula_rn(con,val),con)+")")
    end
    return formul
  end
end
