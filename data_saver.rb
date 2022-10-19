require 'json'
title = "Harry Potter"
author = "JK Rowling"

book1 = {:title => "Harry Potter"}
 
puts book1[:title]

file = File.open("test.json")

file_data = file.read

puts file_data