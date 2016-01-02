require "./config/environment"
require 'pry'
require_all './app/models'

class Scraper
  attr_accessor :doc
  attr_reader :html, :url

  def initialize(url)
    @url = url
    file = open(url)
  end

  def save_page(page)
    # name = page.split("/")[3]
    open("test", "wb") do |file|
      open(page) do |uri|
         file.write(uri.read)
      end
    end
  end

  def create_doc
    session = Capybara::Session.new(:selenium)
    session.visit @url
    session.fill_in('Email', :with => 'joshua.k.applebaum@gmail.com')
    session.fill_in('Pass', :with => 'jordan23')
    session.click_button('Login')
    session.visit "https://courses1.gymnasticbodies.com/home/handstand-series/"
    self.doc = Nokogiri::HTML(session.body)
  end

  def scrape_doc
      self.doc.css(".progression-ol li").each do |x|
        unless x.css("a").text == "Rope Climb Mastery & Notes"
          if x.css('a')[0].attribute("href") != nil
            link_1 = Link.new
            link_1.name = "#{x.css('strong').text}"
            link_1.link = "https://courses1.gymnasticbodies.com/" + x.css('a')[0].attribute("href").value.split("/")[1]
          end

          if x.css('a')[1] != nil
            if x.css('a')[1].text != ""
              link_2 = Link.new
              link_2.name = "#{x.css('strong').text}"
              link_2.link = "https://courses1.gymnasticbodies.com/" + x.css('a')[1].attribute("href").value.split("/")[1]
            end
          end
        end
    end
  end

end

class Link
  attr_accessor :name, :link, :link_long
  @@all = []

  def initialize(name: nil, link: nil)
    @name = name
    @link = link
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.print_names
    self.all.each.with_index(1) do |x,index|
      puts "#{index}. #{x.name}"
    end
  end
end

class PageSaver
  def call_handstands
    session = Capybara::Session.new(:selenium)
    session.visit 'https://courses1.gymnasticbodies.com/fl-pe1/'
    session.fill_in('Email', :with => 'joshua.k.applebaum@gmail.com')
    session.fill_in('Pass', :with => 'jordan23')
    session.click_button('Login')
    Link.all.each_with_index do |x, index|
      session.visit x.link
      doc = Nokogiri::HTML(session.body)
      Template.all.each do |y|
        exercise = BaseExercise.new
        exercise.name = doc.css("strong").text
        exercise.template_id = y.id
        exercise.save
      end
    end
    binding.pry
  end
end

# url = "https://courses1.gymnasticbodies.com/home/handstand-series/"
# josh = Scraper.new(url)
# josh.create_doc
# josh.scrape_doc
# PageSaver.new.call_handstands
