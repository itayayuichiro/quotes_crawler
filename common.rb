require 'rubygems'
require 'bundler'
require 'nokogiri'
require 'socket'
require 'open-uri'
require 'active_record'
require 'active_support'
require 'active_support/core_ext'
require 'pp'
require 'csv'
require 'yaml'
require 'date'
require 'json'
require 'open_uri_redirections'
require 'mechanize'
ActiveRecord::Base.establish_connection(
      :adapter  => 'mysql2',
      :charset => 'utf8mb4',
      :encoding => 'utf8mb4',
      :collation => 'utf8mb4_general_ci',
      :database => 'quotes',
      :host     => 'localhost',
      :username => 'root',
      :password => ""
)

# DBのタイムゾーン設定
Time.zone_default =  Time.find_zone! 'Tokyo' # config.time_zone
ActiveRecord::Base.default_timezone = :local # config.active_record.default_timezone
class Quote < ActiveRecord::Base
end
class Emotion < ActiveRecord::Base
end
