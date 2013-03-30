class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 R)
  end

  def self.same_director(director)
    Movie.where(:director => director)
  end
end
