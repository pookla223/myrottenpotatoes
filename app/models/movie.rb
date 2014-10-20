class Movie < ActiveRecord::Base
  before_save :capitalize_title

  def capitalize_title
    self.title = self.title.split(/\s+/).map(&:downcase).
      map(&:capitalize).join(' ')
  end

  def self.all_ratings; %w[G  PG PG-13 R NC-17] end # shortcut; array of string
  validates :title, :presence => true
  validates :release_date, :presence => true
  validate :released_1930_or_later #uses custom validator below
  validates :rating, :inclusion => {:in => Movie.all_ratings}, :unless => :grandfathered?

  def released_1930_or_later
    error.add(:release_date, 'must be 1930 or later') if
      release_date && release_date < Date.parse('1 jan 1930')
  end

  @@grandfathered_date = Date.parse('1 Nov 1968')
  def grandfathered?
    release_date && release_date >= @@gransfathered_date
  end
end

#try in console:
#m = Movie.create!(:title => 'STAR  wars', :release_date => '27-5-1977')
#m.title  # => "Star Wars"
#m = Movie.new(:title => 'st', :rating=> 'RG', :release_date => '1929-01-01')
# force validation checks to be performed:
#m.valid? #=>false
#m.errors[:title] #=> ["con't be blank"]
#m.errors[:rating] #=> ["is not included in the list"]
#m.errors[:release_date] #=> ["must be 1930 or later"]
#m.errors.full_messages #=> ["Title can't be blank", "Rating is not included in the list","Release date must be 1930 or later"]


