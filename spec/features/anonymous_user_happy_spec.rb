require 'spec_helper'

feature 'Anonymous User visits the site and enters an ugly URL' do
  scenario 'they get back a beautiful one', js: true do
    visit root_path

    fill_in 'url[original]', with: 'https://www.twitter.com'
    click_button 'Make Beautiful'
    sleep(0.5)
    url = Url.find_by(original: 'https://www.twitter.com')
    input = find_field('url[original]').value

    expect(page).to have_content "Beautiful URL:"
    expect(input).to have_content url_path(url)
  end

  scenario 'that has already been made beautiful', js: true do
    Url.create!(original: 'https://www.twitter.com')
    visit root_path

    fill_in 'url[original]', with: 'https://www.twitter.com'
    click_button 'Make Beautiful'
    sleep(0.5)
    urls = Url.all

    expect(urls.count).to eq 1
  end

  scenario 'they click the beautiful one' do
    url = Url.create!(original: 'https://www.twitter.com')
    visit url_path(url)

    expect(current_url).to eq 'https://www.twitter.com/'
  end

  scenario 'they expected the most popular links' do
    url_1 = Url.create!(original: 'https://www.twitter.com', popularity: 8)
    url_2 = Url.create!(original: 'https://www.google.com', popularity: 4)
    url_3 = Url.create!(original: 'https://www.facebook.com', popularity: 9)
    expected_popular = [url_3.original, url_1.original, url_2.original]

    visit root_path
    actual_popular = all('#popular td').map(&:text)

    expect(actual_popular).to eq expected_popular
    expect(page).to have_content "Popular Links"
  end

  scenario 'they expected the newest links' do
    url_1 = Url.create!(original: 'https://www.twitter.com')
    url_2 = Url.create!(original: 'https://www.google.com')
    url_3 = Url.create!(original: 'https://www.facebook.com')
    expected_new = [url_1.original, url_2.original, url_3.original]

    visit root_path
    actual_new = all('#new td').map(&:text)

    expect(actual_new).to eq expected_new
    expect(page).to have_content "New Links"
  end
end
