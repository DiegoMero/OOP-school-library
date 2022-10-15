require './person'

class Student < Person
  def initialize(age, name = 'Unknown', classroom = 'No classroom yet', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
  end

  attr_reader :classroom
  attr_accessor :parent_permission

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end
