require 'pg'

class Connection
  attr_reader :connexion
  attr_writer :connexion

  def initialize()
    @host = String('localhost')
    @database = String('road2')
    @user = String('postgres')
    @password = String('pixel')
  end

  def pgCon()
    con = PG::Connection.new(:host => @host, :user => @user, :dbname => @database, :port => '5432', :password => @password)
    return con
  end
end