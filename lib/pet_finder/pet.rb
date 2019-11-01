class PetFinder::Pet
  attr_accessor :name, :primary_breed, :secondary_breed, :age, :gender, :health, :size, :url

  @@all = []

  def initialize(attributes)
    @name = attributes[:name]
    @age = attributes[:age]
    @gender = attributes[:gender]
    @primary_breed = attributes[:primary_breed]
    @secondary_breed = attributes[:secondary_breed]
    @size = attributes[:size]
    @health = attributes[:health]
    @url = attributes[:url]

    @@all << self
  end

  def self.all
    @@all
  end

  def self.find(input)
    self.all[input.to_i - 1]
  end
end
