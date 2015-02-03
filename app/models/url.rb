class Url < ActiveRecord::Base
  before_save { |url| url.short = url.generate_short_url }

  def generate_short_url
    ('a'..'z').to_a.shuffle[0,5].join
  end
end
