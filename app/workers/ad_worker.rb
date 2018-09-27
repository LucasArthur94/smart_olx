require 'open-uri'

class AdWorker
  include Sidekiq::Worker

  def perform()
    find_ads(%w[macbook pro], 1)
    find_ads(%w[mac book pro], 1)
  end

  private

  def find_ads(words, current_page)
    query = words.split.join("+")

    page = Nokogiri::HTML(open("https://sp.olx.com.br/sao-paulo-e-regiao?o=#{current_page}&q=#{query}"))

    results = page.at_css("ul[id='main-ad-list']").css('li')
    results.map do |result|
      olx_url = result.css(".OLXad-list-link").xpath("@href")&.first&.value
      olx_id = result.css(".OLXad-list-link").xpath("@id")&.first&.value
      title = result.css(".OLXad-list-link").xpath("@title")&.first&.value
      string_price = result.css(".OLXad-list-price").text
      price = string_price&.gsub!(' R$ ', '')&.gsub!(".", "") if string_price

      existing_ad = Ad.find_by(olx_id: olx_id)
      contains_relevant_keywords = title =~ /mac book pro/i or title =~ /macbook pro/i or title =~ /mac bookpro/i or title =~ /macbookpro/i

      if existing_ad
        if existing_ad.price != price.to_f
          existing_ad.price = price
          existing_ad.is_new = true
        else
          existing_ad.is_new = false
        end
        existing_ad.save
      elsif olx_url and olx_id and title and price and (title) and contains_relevant_keywords
        new_ad = Ad.new({ price: price, olx_url: olx_url, title: title, olx_id: olx_id, is_new: true })
        new_ad.save
      end
    end
    find_ads(words, current_page + 1) unless page.css(".next").empty?
  end
end
