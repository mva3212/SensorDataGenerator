require 'httparty'
require 'yajl/json_gem'

stations = IO.readlines('stations.txt')
baseguid = stations.at(0)
stations.delete_at(0)

while true
  post_data = "{'messageType':'SensorData', 'mac':'00aabbccde02', 'guid': '#{baseguid.chop}', 'stationPackets':["
  stations.each do |station|
     datastring = "{'stationType':'Sensor','pid':#{station.chomp},'temp':#{rand(100)}, 'humidity':#{rand(100)},'tempProbe':#{rand(100)}, 'moisture':#{rand(100)}, 'lux':#{rand(10000)}, 'ir':#{rand(10000)}},"
     post_data += datastring
  end
  post_data.chop!
  post_data += "]}"
  post_data= post_data.gsub("'","\"")
  result = HTTParty.post('http://localhost:4567/api', :body => post_data, :headers => {'Content-Type' => 'application/json', 'Accept' => 'application/json'})
  sleep(30);
end

