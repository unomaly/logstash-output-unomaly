[![Build Status](https://travis-ci.org/unomaly/logstash-output-unomaly.svg?branch=master)](https://travis-ci.org/unomaly/logstash-output-unomaly)

This plugin sends Logstash events to the [Unomaly](https://www.unomaly.com) ingestion API (min version Unomaly 2.27).

# Getting started

## Installing through rubygems

Run the following on your Logstash instance

`logstash-plugin install logstash-output-unomaly`

## Minimal configuration
```
output {
    unomaly {
        host => "https://your-unomaly-instance:443"
    }
}
```


# Important options


| Option                     | Description                                                                      | Default    |
|----------------------------|----------------------------------------------------------------------------------|------------|
| host                       | Unomaly instance address. Must define full path such as "https://my-instance:443"| No default |
| message_key                | The key in the Logstash event that Unomaly should use for anomaly detection.     | "message"  |
| source_key                 | The event key defining the Unomaly system.                                       | "host"     |
| ssl_certificate_validation | Enable or disable SSL certificate validation                                     | "strict"   |
| keep_timestamp             | If false, Unomaly will use the ingestion timestamp as the event timestamp        | true       |

See the [source code](lib/logstash/outputs/unomaly.rb) for the full list of options

The syntax for `message_key` and `source_key` values are available in the [Logstash Event API Documentation](https://www.elastic.co/guide/en/logstash/current/event-api.html)

## Known issues 
 - Installation of the plugin fails on Logstash 6.2.1.
 
 
 ## Contributing
 
 Bug reports and pull requests are welcome. This project is intended to
 be a safe, welcoming space for collaboration.
 
 ## Development
 
We use docker to build the plugin. You can build it by running  `docker-compose run jruby gem build logstash-output-unomaly.gemspec `
