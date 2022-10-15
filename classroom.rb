require './student'

class Classroom
  def initialize(label)
    @label = label
    @students = []
  end

  attr_accessor :label  
  attr_reader :students

  def add_student(student)
    @students.push(student)
    student.classroom = self
  end
end

student_1 = Student.new(20, 7, "Dieg  o")

student_2 = Student.new(18, 7, "Maykol")

lololol = Classroom.new(5)

lololol.add_student(student_1)

lololol.add_student(student_2)

puts lololol.students[1].classroom