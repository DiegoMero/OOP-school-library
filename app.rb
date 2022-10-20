require './book'
require './rental'
require './student'
require './teacher'
require 'json'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def load_data
    book_data = File.open('books.json')
    book_data = book_data.read
    book_data = JSON.parse(book_data)
    book_data.map { |book| @books.push(Book.new(book['title'], book['author'])) }

    people_data = File.open('people.json')
    people_data = people_data.read
    people_data = JSON.parse(people_data)
    people_data.each do |person|
      if person['type'] == 'Student'
        @people.push(Student.new(person['age'], person['name'], parent_permission: person['permission']))
      else
        @people.push(Teacher.new(person['age'], person['specialization'], person['name']))
      end
    end

    rentals_data = File.open('rentals.json')
    rentals_data = rentals_data.read
    rentals_data = JSON.parse(rentals_data)
    rentals_data.map do |rental|
      @rentals.push(Rental.new(rental['date'], @books[rental['book_index']], @people[rental['person_index']]))
    end
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
    when 7
      save_rental_data
      save_data
      exit
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

  def save_data
    @books = @books.map { |book| { title: book.title, author: book.author } }
    @books = JSON.generate(@books)
    File.write('books.json', @books)

    @people = @people.map do |person|
      if person.instance_of?(::Student)
        { age: person.age, name: person.name, permission: person.parent_permission,
          type: person.class.name }
      else
        { age: person.age, name: person.name, specialization: person.specialization,
          type: person.class.name }
      end
    end
    @people = JSON.generate(@people)
    File.write('people.json', @people)
  end

  def save_rental_data
    @rentals = @rentals.map do |rental|
      rental = { date: rental.date, book_index: @books.find_index do |book|
                                                  book.title == rental.book.title
                                                end, person_index: @people.find_index do |person|
                                                                     person.id == rental.person.id
                                                                   end }
    end
    @rentals = JSON.generate(@rentals)
    File.write('rentals.json', @rentals)
  end
end
