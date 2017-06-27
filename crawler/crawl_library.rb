
require_relative './base_crawler.rb'

class CrawlLibrary < BaseCrawler
  def get_html(url)
    json = open_url(url)
    doc = JSON.parse(json)
    doc["html"]
  end
  def get_total(url)
    json = open_url(url)
    doc = JSON.parse(json)
    doc["total_count"].to_i
  end

  def crawl_content
    #海外TV,国内TV,海外映画
    html  = open_url('http://40s-animeigen.com/sakuhin/')
    doc = Nokogiri::HTML(html)
    doc.css('.cat-item').each do |li|
      get_quotes(li.css('a')[0][:href])
    end
  end
  def get_quotes(url)
    html = open_url(url)
    doc = Nokogiri::HTML(html)
      doc.css('.clearfix').each do |li|
        # puts li.css('dd h3 a')[0].text.gsub(/\R| /, "")
        # puts li.css('.pcone b a')[0].text
        # puts li.css('.pcone b a')[1].text
        word = li.css('dd h3 a')[0].text.gsub(/\R| /, "")
        title = li.css('.pcone b a')[0].text
        if li.css('.pcone b a')[1].blank?

        else
          char = li.css('.pcone b a')[1].text
          li.css('.pcone')[1].css('b a').each do |a|
            Emotion.new(:emotion => a.text,:word =>word,:title => title,:char=>char).save     
          end
        end
        puts '--------------'
      end      
        end
  def open_url(url)
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    return html
  end
  def insert_db(url,html)
    Content.new(:url => url,:html => html).save 
  end

end

crawler = CrawlLibrary.new
agent = crawler.crawl_content
