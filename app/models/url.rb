class Url < ActiveRecord::Base
  scope :popular, -> { order(popularity: :desc) }
  scope :newest, -> { order(:created_at) }

  before_save { |url| url.short = url.generate_short_url }

  def generate_short_url
    ('a'..'z').to_a.shuffle[0,5].join
  end
end
