#!/opt/chef/embedded/bin/ruby
require 'json'
require 'open-uri'
require 'optparse'

options = {:uri => 'http://localhost:9200/', :keep => 5, :index => 'logstash'}

parser = OptionParser.new do |opts|
  opts.banner = "Usage: optimize.rb [options]"
  opts.on('-u', '--uri uri', 'URI of Elasticsearch server (http://localhost:9200/') do |uri|
    options[:uri] = uri
  end

  opts.on('-k', '--keep keep', 'Indexes to rotate (5)') do |keep|
    options[:keep] = keep
  end

  opts.on('-i', '--index index', 'Index prefix to work on (logstash)') do |index|
    options[:index] = index
  end

  opts.on('-h', '--help', 'Displays Help') do
    puts opts
    exit
  end
end

parser.parse!

status = JSON.parse(open(URI.join(options[:uri], '/_status')).read)
indexes = status['indices'].keys.sort
indexes = indexes.grep /^#{options[:index]}/

if indexes.empty?
  puts "No indexes matching /^#{options[:index]}/ found"
  exit 1
end

last_index = 0 - Integer(options[:keep])
# optimize the last options[:keep] indexes
indexes[last_index..-1].each do |i|
  puts `curl -s -XPOST "#{URI.join(options[:uri], i, '_optimize')}"`
end