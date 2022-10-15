require './book'
require './rental'
require './student'
require './teacher'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def run_action(menu_option)
    case menu_option
    when 1
      book_list
    when 2
      person_list
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      rental_list
    else
      puts 'Please enter a valid value'
    end
  end

  def book_list
    @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
  end

  def person_list
    @people.each { |person| puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    puts 'Book created successfully'
    @books.push(book)
  end

  def create_student
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp
    permission = permission.include?('y' || 'Y')
    student = Student.new(age, name, parent_permission: permission)
    puts 'Person created successfully'
    @people.push(student)
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name)
    puts 'Person created successfully'
    @people.push(teacher)
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher(2)? [Input the number]: '
    option = gets.chomp.to_i
    case option
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Please enter a valid value'
    end
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, index| puts "#{index}) Title: '#{book.title}', Author: #{book.author}" }
    book_selected = gets.chomp.to_i
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index { |el, i| puts "#{i}) [#{el.class.name}] Name: #{el.name}, ID: #{el.id}, Age: #{el.age}" }
    person_selected = gets.chomp.to_i
    print 'Date: '
    date = gets.chomp
    rental = Rental.new(date, @books[book_selected], @people[person_selected])
    puts 'Rental created successfully'
    @rentals.push(rental)
  end

  def rental_list
    print 'ID of person: '
    id_selected = gets.chomp.to_i
    new_rental_list = @rentals.select { |rental| rental.person.id == id_selected }
    puts 'Rentals: '
    new_rental_list.each { |rental| puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}" }
  end
end
