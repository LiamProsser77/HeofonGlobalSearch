print "Enter your search: "
user_query = gets.chomp.downcase

if user_query == "norway"
  puts "Displaying results for Norway..."
else
  puts "Searching for: #{user_query}"
end
