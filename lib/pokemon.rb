require 'pry'
class Pokemon

    attr_accessor :name, :type, :id, :db

    def initialize(attr)
        attr.each{|key, value| self.send("#{key}=", value)}
    end

    def self.save(name, type, db)
        sql = "INSERT INTO pokemon(name, type) VALUES (?, ?)"
        db.execute(sql, [name, type])
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = "SELECT * FROM pokemon WHERE id = ?"
        attr = db.execute(sql, id)[0]
        pokemon = self.new(id: attr[0], name: attr[1], type: attr[2])
        pokemon
    end

end
