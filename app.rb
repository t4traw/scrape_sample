require 'bundler'
Bundler.require

URL = "https://books.rakuten.co.jp/event/book/comic/calendar/"

options = Selenium::WebDriver::Chrome::Options.new
# options.add_argument('--headless')
driver = Selenium::WebDriver.for :chrome, options: options

driver.get(URL)

result = []
driver.find_elements(:class, 'bookcomic-calendar').each do |li|
  row = []
  row << li.find_element(:class, 'bookdate').text
  row << li.find_element(:class, 'bookttl').text
  row << li.find_element(:class, 'bookauthor').text
  row << li.find_element(:class, 'bookpublisher').text
  p row
  result << row
end
driver.quit

csv_header = ['bookdate', 'bookttl', 'bookauthor', 'item-athr']

CSV.open('result.csv', 'w') do |csv|
  csv << csv_header
  result.each do |row|
    csv << row
  end
end
