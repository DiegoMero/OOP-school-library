require './app'

def main
  app = App.new

  loop do
    puts 'Please choose an option by enterin a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
    menu_option = gets.chomp.to_i

    case menu_option
    when 1
      app.book_list
    when 2
      app.person_list
    when 3
      app.create_person
    when 4
      app.create_book
    when 5
      app.create_rental
    when 6
      app.rental_list
    when 7
      exit
    else
      puts 'Please enter a valid value'
    end
  end
end

main
