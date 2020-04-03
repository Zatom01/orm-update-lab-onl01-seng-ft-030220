require_relative "../config/environment.rb"

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  
  attr_accessor :name, :grade,:id
 
  
  def initialize(name,grade,id=nil)
    @name=name
    @grade=grade
    @id=id 
  end 
  
  def self.create_table 
    sql="CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT,grade TEXT)"
    DB[:conn].execute(sql)
  end 
  
  def self.drop_table
    sql="DROP TABLE students"
    DB[:conn].execute(sql)
  end 
  
  def save 
    if self.id 
      self.update
    else 
      sql="INSERT INTO students(name,grade) VALUES (?,?)"
      DB[:conn].execute(sql,self.name,self.grade)
      @id=DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end 
    
    
  end 
  
  def self.create(name,grade)
    student=self.new(name,grade)
    student.save
    student
  end 
  
  def self.new_from_db(row)
    student=Student.new 
    student.id=row[0]
    student.name=row[1]
    student.grade=row[2]
  end 


end
