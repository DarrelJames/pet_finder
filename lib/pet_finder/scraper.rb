class PetFinder::Scraper

  # def self.scrape_pets(type, state, zip)
  #   doc = Nokogiri::HTML(open("https://www.petfinder.com/search/#{type}s-for-adoption/us/#{state}/#{zip}/?days_on_petfinder=1"))
  #
  #   pets = doc.css("div.grid_gutterLg div")
  #   binding.pry
  # end

  def self.get_pets(type, zip)
    key = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6Ijk5MDJlZGMxYWZiZmYyZWVmMWJkOTNkNDQwODRhOTI4YWM2YWMxZDcyZDE5NGMxYTFlM2IwYzQ2ODRjZjViOTM0NGQ1NTFjNzhkZWZlZjNmIn0.eyJhdWQiOiIzT2dYTmE5bmFLbVp6QmllbGVodXZvYTJrZWNhMkdxeXp4Wm1VTjhkNmd6Z1FtUThTMCIsImp0aSI6Ijk5MDJlZGMxYWZiZmYyZWVmMWJkOTNkNDQwODRhOTI4YWM2YWMxZDcyZDE5NGMxYTFlM2IwYzQ2ODRjZjViOTM0NGQ1NTFjNzhkZWZlZjNmIiwiaWF0IjoxNTcyNTgxNjg0LCJuYmYiOjE1NzI1ODE2ODQsImV4cCI6MTU3MjU4NTI4NCwic3ViIjoiIiwic2NvcGVzIjpbXX0.M70CIzgUaeW_S_Xw6Z2fkuI5i-G1ntpBe8oQZbV8bbFt59VWnE4j8EmVGbCRhItm-txLuC25vEp4Y6yN-dcxytI3E2P8aCqegBx2AKFlZg7C5ChlBFeTcuYFTni7Xsth7vUCMEiaeF2yo8Pe9XT_f4995j5nh_0bWr-bZGF27gEwLko3LK7OzVl4RlFfXqzjr7lnrr48VoKi1VXMGgBpPQoOhuJTh7lcsz7TEzO33ng_lrm8ViVJlexUQku-jcEI3c6xRW05RX-43zOPmX91lRUooqKOxdtUWElG-SfTa9-7rFBgCObLjHOu-xamKDzWKe-pY5frH-7c7BPfkzNw0A"
    url = "https://api.petfinder.com/v2/animals?type=#{type}&location=#{zip}&limit=30"
    response = HTTParty.get(url, headers: {'Authorization' => "Bearer #{key}"})

    response["animals"].each do |animal|
      
      attributes = {

        name: animal["name"],
        age: animal["age"],
        gender: animal["gender"],
        primary_breed: animal["breeds"]["primary"],
        secondary_breed: animal["breeds"]["secondary"],
        size: animal["size"],
        health: animal["attributes"],
        url: animal["url"]

      }

      PetFinder::Pet.new(attributes)
    end
  end

end

#:name, :breed, :age, :gender, :health, :description
