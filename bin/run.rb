require_relative '../config/environment'

cli = CLI.new
cli.welcome
cli.find_create_user
cli.get_user_restaurant
cli.update_list