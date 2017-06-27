
require_relative './base_crawler.rb'

class CrawlMaxim < BaseCrawler
  def login
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari 4'
    agent.user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
    agent
  end

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
    html  = open_url('http://phoenix-wind.com/maxim/anime/')
    doc = Nokogiri::HTML(html)
    doc.css('.item .listnavi a').each do |a|
      if a[:href].match(/maxim/)
        get_quotes(a[:href])
      end
    end
  end
  def get_quotes(url)
    html = agent.get url
    doc = Nokogiri::HTML(html)
    
    doc.css('.')
    agent = login

    agent.post url, "foo" => "bar"
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
    Contents.new(:url => url,:html => html).save 
  end

end

crawler = CrawlMaxim.new
agent = crawler.crawl_content
