require 'spec_helper'

describe docker_container('marathon') do
  it { should be_running }
  it { should have_volume('/tmp/docker.sock','/var/run/docker.sock') }
  it { should have_volume('/store','/etc/marathon/store') }
end

describe port(8080) do
  it { should be_listening }
end

describe command("/usr/local/bin/marathon-wait-for-listen.sh") do
  its(:exit_status) { should eq 0 }
end

describe service('marathon') do
  it { should be_running.under('upstart') }
end



