# encoding: utf-8
require "logstash/devutils/rspec/spec_helper"
require "logstash/outputs/unomaly"
require "logstash/event"

describe LogStash::Outputs::Unomaly do
  let(:sample_event) { LogStash::Event.new("message" => "hello this is log") }
  let(:client) { @unomaly.client }

  before do
    @unomaly = LogStash::Outputs::Unomaly.new("host" => "localhost", "batch_size" => 3)
    @unomaly.register
    allow(@unomaly).to receive(:client).and_return(client)
    allow(client).to receive(:post).and_call_original
  end

  before do
    allow(@unomaly).to receive(:client).and_return(client)
  end


  it "Forwards an event" do
      expect(client).to receive(:post).once.and_call_original
      @unomaly.multi_receive([sample_event])
  end

  it "Batches multiple events and extracts metadata" do
    event1 = LogStash::Event.new("message" => "hello this is log 1", "host" => "host1")
    event2 = LogStash::Event.new("message" => "hello this is log 2", "host" => "host2")
    event3 = LogStash::Event.new("message" => "hello this is log 3", "host" => "host3")
    expect(client).to receive(:post).once.with("localhost/v1/batch",hash_including(:body => LogStash::Json.dump(
        [{"message" => "hello this is log 1", "source" => "host1", "timestamp" => event1.timestamp.to_s, "metadata" => {"@version" => "1"}},
        {"message" => "hello this is log 2", "source" => "host2", "timestamp" => event2.timestamp.to_s, "metadata" => {"@version" => "1"}},
        {"message" => "hello this is log 3", "source" => "host3", "timestamp" => event3.timestamp.to_s, "metadata" => {"@version" => "1"}}
        ]
        ))).and_call_original
    @unomaly.multi_receive([event1, event2, event3])
  end

  it "Batches data of size batch_size" do
    expect(client).to receive(:post).exactly(2).times.and_call_original
    @unomaly.multi_receive([sample_event, sample_event, sample_event, sample_event])
  end


end
