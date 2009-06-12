Given %r{^I have a valid (.*) url$} do |affiliate|
  @url = case affiliate.downcase
  when 'tradedoubler'
    'http://pf.tradedoubler.com/export/export?myFeed=12447176721639142&myFormat=12446402641639142'
  when 'dgmpro'
    'http://feeds.perfb.com/index.php/download?OEMAIL=neil@venturian-media.com&PX=cc54679b46dc85d67b50072a65c4c0f0&DISPLAYFORMAT=XML&REVERSEMAPXML=yes&PRODUCTDB_ID=176'
  when 'affiliatewindow'
    'http://datafeed.api.productserve.com/datafeed/download/apikey/09e9ebe98023f6864252f0569f49fc69/cid/281,283,298,554,285,555,303,304,286,282,287,288/columns/merchant_id,merchant_name,aw_product_id,merchant_product_id,upc,ean,mpn,isbn,model_number,product_name,description,specifications,promotional_text,merchant_category,category_id,category_name,language,brand_name,merchant_deep_link,merchant_thumb_url,merchant_image_url,aw_deep_link,aw_thumb_url,aw_image_url,delivery_time,valid_from,valid_to,currency,search_price,store_price,rrp_price,display_price,delivery_cost,web_offer,pre_order,in_stock,stock_quantity,is_for_sale,warranty,condition,product_type,parent_product_id,commission_group/format/xml/compression/gzip/'
  when 'tradedoublerquality'
    'http://pf.tradedoubler.com/export/export?myFeed=1244725336407311&myFormat=1244725336407311'    
  end
end

Given %r{I have valid (.*) element mappings$} do |affiliate|
  @element_map = case affiliate
  when 'Tradedoubler'
    {
      :products => "products",
      :product => "product", 
      :uid => "TDProductId",
      :url => "productUrl",
      :price => "price",
      :name => "name",
      :description => "description"
    }
  when 'dgmpro'
    {
      :products => "products",
      :product => "product", 
      :uid => "product_code",
      :url => "buyat_short_deeplink_url",
      :price => "full_price_line_rental",
      :name => "product_name",
      :description => "description"
    }
  when 'affiliatewindow'
    {
      :merchant_groups => 'merchant',
      :products => "products",
      :product => "product", 
      :uid => "product_code",
      :url => "buyat_short_deeplink_url",
      :price => "full_price_line_rental",
      :name => "product_name",
      :description => "description"
    }
  end
end

When %r{^I fetch that feed$} do
  @feed = Feeder::Feed.new( @url, @element_map )
  @response = @feed.fetch
end

Then %r{^when I parse it I should have fetched a valid xml file$} do
  @response.should_not == nil
end

Given %r{^I have a valid (.*) (.*) feed$} do |size, affiliate|
  @feed_file = File.join(File.dirname(__FILE__), %W[ .. .. test fixtures feeds #{size} #{affiliate.downcase}.xml ])
end

When %r{^I parse that feed$} do
  @parser = Feeder::Parser.new( @feed_file, @element_map )
  @products = @parser.parse
end

Then %r{^I should have multiple products$} do
  @products.size.should > 0
end

Then %r{^those products should be valid$} do
  @products.each do |product|
    assert OpenStruct, product.class
    (@element_map.keys - [ :products, :product ]).each do |element|
      assert product.respond_to?(element)
    end
  end
end