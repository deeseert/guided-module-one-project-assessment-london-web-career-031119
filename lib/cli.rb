class CLI
  # attr_writer :user_name

  def initialize
    @prompt = TTY::Prompt.new
  end

  def welcome
    puts 'Welcome to Felp, the best resource for restaurant information in the world!'
  end

  def find_create_user
    puts "Heya! let me find your account!"
    user_name = @prompt.ask("Enter your name here")
    @user = User.find_by(name: user_name)

    if @user.nil?
      puts "Woops! Didn't find your account...but don't worry I just created it for you!"
      @user = User.create(name: user_name)
    else
      puts "Hey #{user_name}! Hope you enjoyed the restaurant I suggested you last time! ;)"
    end

  end

  # def input_restaurant
  #
  # end

  def get_user_restaurant
    response = @prompt.yes?("Would you like to see your fav restaurants?")
    if response == true
      puts "Here is the list of your restaurants:"
      puts @user.restaurants.each_with_index.map {|restaurant, i| "#{i + 1}. #{restaurant.name}"}
    else
      puts "Ok, that's fine"
    end
    # sergio = User.find_by(name: se.name)
  end

def update_list
  response = @prompt.yes?("Would you like to add your favorite restaurant?")
  if response
    rest_update = @prompt.ask("Please enter the restaurant below:")
    new_rest = Restaurant.find_or_create_by(name: rest_update)
    puts new_rest.name
  end
end

end
