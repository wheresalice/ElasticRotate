# Elastic Rotate

A set of ruby scripts to delete, optimize and list Elasticsearch indexes.  Doesn't require nasty Python pip installs like the official [Curator][1] does.

All tools take an optional uri for the elasticsearch server, defaulting to http://localhost:9200/

* list.rb lists indexes
* rotate.rb deletes all but the last 28 indexes matching /^logstash/ (regex and number configurable)
* optimize.rb optimizes the latest index

Pass in -h to get a list of options for each tool.

  [1]: https://github.com/elasticsearch/curator
