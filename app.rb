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

  def create_person
    print 'Do you want to create a student (1) or a teacher(2)? [Input the number]: '
    option = gets.chomp
    option = option.to_i
    case option
    when 1
      print 'Age: '
      age = gets.chomp
      print 'Name: '
      name = gets.chomp
      print 'Has parent permission? [Y/N]: '
      permission = gets.chomp
      if permission == "y" || permission == "Y"
        parent_permission = true
      else
        parent_permission = false
      end
      student = Student.new(age, name, parent_permission: parent_permission)
      puts 'Person created successfully'
      @people.push(student)
    when 2
      print 'Age: '
      age = gets.chomp
      print 'Name: '
      name = gets.chomp
      print 'Specialization: '
      specialization = gets.chomp
      teacher = Teacher.new(age, specialization, name)
      puts 'Person created successfully'
      @people.push(teacher)
    else
      puts 'Please enter a valid value'
    end
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, index| puts "#{index}) Title: '#{book.title}', Author: #{book.author}" }
    book_selected = gets.chomp
    book_selected = book_selected.to_i
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index { |person, index|
      puts "#{index}) [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    }
    person_selected = gets.chomp
    person_selected = person_selected.to_i
    print 'Date: '
    date = gets.chomp
    rental = Rental.new(date, @books[book_selected], @people[person_selected])
    puts 'Rental created successfully'
    @rentals.push(rental)
  end

  def rental_list
    print 'ID of person: '
    id_selected = gets.chomp
    id_selected = is_selected.to_i
    new_rental_list = @rentals.select { |rental| rental.person.id == id_selected }
    puts 'Rentals: '
    new_rental_list.each { |rental| puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}" }
  end
end
