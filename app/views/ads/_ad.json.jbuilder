json.extract! ad, :id, :title, :price, :olx_id, :olx_url, :is_new, :created_at, :updated_at
json.url ad_url(ad, format: :json)
