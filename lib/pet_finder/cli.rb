class PetFinder::CLI

  def call
    puts "Welcome to pet finder"
    start
  end

  def start
    get_pets
    back
  end

  def back
    list_pets
    ask_for_pet_selection
    print_details
    menu
  end

  def ask_for_dog_or_cat
    puts "Please enter dog or cat"
    input = gets.strip.downcase

    if input == "dog"
      input
    elsif input == "cat"
      input
    else
      puts "Invalid Input, Please Try Again"
      ask_for_dog_or_cat
    end
  end

  def ask_for_zipcode
    puts "Please enter a valid zip code"
    input = gets.strip

    if input.size == 5
       input
    else
      puts "Invalid Input, Please Try Again"
      ask_for_zipcode
    end
  end

  def get_pets
    type = ask_for_dog_or_cat
    zip = ask_for_zipcode

    PetFinder::Pet.all.clear
    PetFinder::API.get_pets(type, zip)
  end

  def list_pets
    PetFinder::Pet.all.each.with_index(1) do |pet, index|
      puts "#{index}. #{pet.name} - #{pet.primary_breed}#{", #{pet.secondary_breed}" if pet.secondary_breed}"
    end
  end

  def ask_for_pet_selection
    puts "Please enter a number to learn more about a pet"
    input = gets.strip.downcase

    if input.to_i.between?(1, PetFinder::Pet.all.size)
      @pet = PetFinder::Pet.find(input)
    end
  end

  def print_details


    puts "Name: #{@pet.name}"
    puts "Breed: #{@pet.primary_breed}#{", #{@pet.secondary_breed}" if @pet.secondary_breed}"
    puts "Gender: #{@pet.gender}"
    puts "Size: #{@pet.size}"

    puts "\nHealth Details:"

    @pet.health.each do |attribute, value|
      puts "#{attribute}: #{value ? "Yes" : "No"}"
    end


    puts "\n\nFor adoption information, please visit:"
    puts "#{@pet.url}"

  end

  def menu
    puts "\n---------------------------------------------"
    puts "To go back to list of pets, enter 'back'."
    puts "To search a new pet, enter 'new'."
    puts "To quit, enter 'exit'."
    puts "---------------------------------------------"
    input = gets.strip.downcase

    case input
    when "back"
      back
    when "new"
      start
    when "exit"
      puts "Goodbye"
      exit
    else
      puts "Invalid Input, Please Try Again"
      menu
    end
  end

end
