# frozen_string_literal: true
require_relative 'utils'
class Entreprise
  attr_accessor  :id, :nom, :prix, :vitesse, :employe, :penalite, :age,:dateCreation

  def initialize

  end

  def set_age(age)
    self.age = age
  end
  def set_id(id)
    self.id = id.to_i
  end
  def set_nom(nom)
    self.nom = nom
  end

  def set_prix(prix)
    self.prix = prix.to_f
  end

  def set_vitesse(vitesse)
    self.vitesse = vitesse.to_f
  end

  def set_employe(employe)
    self.employe = employe.to_i
  end

  def set_penalite(penalite)
    self.penalite = penalite.to_f
  end

  def set_date_creation(date_creation)
    self.dateCreation = date_creation
  end



  def self.all_entreprise(connection)
    query = "select * from info_prestataire order by nom asc"
    data = connection.exec(query)
    result = []
    i = 0
    data.each do |row|
      temp_entreprise = Entreprise.new()
      temp_entreprise.set_id(row['id'])
      temp_entreprise.set_nom(row['nom'])
      temp_entreprise.set_employe(row['employe'])
      temp_entreprise.set_prix(row['prix'])
      temp_entreprise.set_penalite(row['penalite'])
      temp_entreprise.set_vitesse(row['vitesse'])
      temp_entreprise.set_age(row['age'])
      result[i] = temp_entreprise
      i+=1
    end
    return result
  end

  def self.list_prestataire(query,connection)
    puts(query)
    data = connection.exec(query)
    result = []
    i = 0
    data.each do |row|
      temp_entreprise = Entreprise.new()
      temp_entreprise.set_id(row['id'])
      temp_entreprise.set_nom(row['nom'])
      temp_entreprise.set_employe(row['employe'])
      temp_entreprise.set_prix(row['prix'])
      temp_entreprise.set_penalite(row['penalite'])
      temp_entreprise.set_vitesse(row['vitesse'])
      temp_entreprise.set_date_creation(row['dateCreation'])
      result[i] = temp_entreprise
      i+=1
    end
    return result
  end

  def self.rentability(con,road)
    formula = road.formula(con)
    f = Utils.transform(formula[0],con)
    query = sprintf("select %s as rentability from info_prestataire order by rentability desc",f)
    data = con.exec(query)
    rentability_array = []
    data.each do |row|
      rentability_array<<row['rentability']
    end
    return rentability_array
  end
end
