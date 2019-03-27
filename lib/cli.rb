class CLI
  attr_reader :user

  def initialize
    @prompt = TTY::Prompt.new(symbols: {pointer: '>'})
  end

  def stars_decoration
    puts "*******************************************"
  end

  def find_user(name)
    @user = User.find_by(name)
  end

  def create_user(name)
    @user = User.create(name)
  end

  def user_restaurant_name
    @user.restaurants.reload.map(&:name).uniq
  end

  def index_user_restaurant_name
    user_restaurant_name.map.with_index {|restaurant_name, i| "#{i + 1}. #{restaurant_name}"}
  end

  def welcome
    puts 'Welcome to FeedMe, the best resource for restaurant information in the world!'
    stars_decoration
    puts "Heya! let me find your account!"
    stars_decoration
  end

  def find_create_user
    user_name = @prompt.ask("Enter your name here below:")
    find_user(name: user_name)
    if @user.nil?
      puts "Woops! Didn't find your account #{user_name}...but don't worry I just created it for you!"
      create_user(name: user_name)
    else
      puts "Hey #{@user.name}! How you doin'? :)"
    end
  end

  def get_user_restaurant
    #TODO: Limit the choice to yes or not
    stars_decoration
    # response = @prompt.yes?("Would you like to see your fav restaurants?")
    puts "Would you like to see your fav restaurants?(Y/n)"
    response = gets.chomp.downcase
    if response != "y" && response != "n"
      get_user_restaurant
    else
      if response == "y"
        if index_user_restaurant_name.empty?
          stars_decorationstars_decoration
          puts "Woops! Your list is empty...sorry...LOL"
        elsif index_user_restaurant_name
          stars_decorationstars_decoration
          puts "Here is the list of your restaurants:"
          puts index_user_restaurant_name
        end
      else
        stars_decorationstars_decoration
        puts "Ok, that's fine"
      end
    end
  end
    # sergio = User.find_by(name: se.name)


def update_list
  stars_decoration
  response = @prompt.yes?("Would you like to add your favorite restaurant?")
  if response
    stars_decoration
    rest_update = @prompt.ask("Please enter the restaurant below:")
    new_rest = Restaurant.find_or_create_by(name: rest_update)
    Booking.create(restaurant_id: new_rest.id, user_id: @user.id)
    puts new_rest.name
    # binding.pry
    # @user.restaurants << new_rest
    stars_decoration
    puts "That's your new list of restaurants:"
    puts index_user_restaurant_name
  end
  puts "Would you like to add another one by any chance?(Y/n)"
  response2 = gets.chomp.downcase
  if response2 == "y"
    puts "Please, enter it here:"
    response3 = gets.chomp.downcase
    new_rest2 = Restaurant.find_or_create_by(name: response3)
    Booking.create(restaurant_id: new_rest2.id, user_id: @user.id)
    puts new_rest2.name
    stars_decoration
    puts "That's your new list of restaurants:"
    puts index_user_restaurant_name
  else
  puts "Ok! Let's move on!"
  end

end

def delete_restaurant
  stars_decoration
  response = @prompt.yes?("Would you like to remove a restaurant from your list?")
  if response
    stars_decoration
    user_choice_str = @prompt.select("Ok. Choose one below:", user_restaurant_name)
    stars_decoration
    puts "Deleting #{user_choice_str}"
    Restaurant.find_by(name: user_choice_str).destroy
    # binding.pry
    stars_decoration
    puts "here is your new list"
    puts index_user_restaurant_name
  elsif response == false
    stars_decoration
    puts "Ok cool! Enjoy your day!"
  end
end

  def suggest_restaurant
    stars_decoration
    rest_selected = @prompt.select("Before you go, take a look at what other foodies suggest:", Restaurant.get_all_restaurant)
    new_rest_created = Restaurant.find_or_create_by(name: rest_selected)
    rest_picked = Booking.create(restaurant_id: new_rest_created.id, user_id: @user.id)
    stars_decoration
    puts "You just added #{new_rest_created.name} at your list"
    stars_decoration
    user_resp = @prompt.yes?("Would you like to take a look at your list again?")
    if user_resp
      stars_decoration
      puts "here you go:"
      puts index_user_restaurant_name
    elsif user_resp == false
      stars_decoration
      puts "Ok cool! Enjoy your day!"
    end
  end

end
