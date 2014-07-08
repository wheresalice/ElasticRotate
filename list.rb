#!/opt/chef/embedded/bin/ruby
require 'json'
require 'open-uri'
require 'optparse'

options = {:uri => 'http://localhost:9200/'}

parser = OptionParser.new do |opts|
  opts.banner = "Usage: optimize.rb [options]"
  opts.on('-u', '--uri uri', 'URI of Elasticsearch server (http://localhost:9200/') do |uri|
    options[:uri] = uri
  end

  opts.on('-h', '--help', 'Displays Help') do
    puts opts
    exit
  end
end

parser.parse!

status = JSON.parse(open(URI.join(options[:uri], '/_status')).read)
indexes = status['indices'].keys.sort
puts indexes