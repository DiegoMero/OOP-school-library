require './app'

@menu = 'Please choose an option by enterin a number:
1 - List all books
2 - List all people
3 - Create a person
4 - Create a book
5 - Create a rental
6 - List all rentals for a given person id
7 - Exit'

def main
  app = App.new
  loop do
    puts @menu
    menu_option = gets.chomp.to_i
    exit if menu_option == 7
    app.run_action(menu_option)
  end
end

main
