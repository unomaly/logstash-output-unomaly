# Logstash output plugin for Unomaly

This plugin sends Logstash events to the [Unomaly](https://www.unomaly.com) ingestion API (min version Unomaly 2.27). The minimal configuration looks like this:


```
output {
    unomaly {
        host => "https://your-unomaly-instance:443
    }
}
```

# Important options


| Option                     | Description                                                                      | Default    |
|----------------------------|----------------------------------------------------------------------------------|------------|
| host                       | Unomaly instance address. Must define full path such as "https://my-instance:443 | No default |
| message_key                | The key in the Logstash event that Unomaly should use for anomaly detection.     | "message"  |
| source_key                 | The event key defining the Unomaly system.                                       | "host"     |
| ssl_certificate_validation | Enable or disable SSL certificate validation                                     | "strict"   |

See the [source code](lib/logstash/outputs/unomaly.rb) for the full list of options


## Known issues 
 - Installation of the plugin fails on Logstash 6.2.1.
 
 
 ## Contributing
 
 Bug reports and pull requests are welcome. This project is intended to
 be a safe, welcoming space for collaboration. 