require 'table_print'
require 'json'
require 'open3'

cmd = "sudo chmod u+w ."
Open3.popen2e(cmd) do |stdin, stdout_err, wait_thr|
  while line = stdout_err.gets
    puts "#{line}"
  end

  exit_status = wait_thr.value
  unless exit_status.success?
    puts '---------------------'
    puts "FAILED to execute --> #{cmd}"
    puts '---------------------'
  end
end

cmd = "curl http://localhost:3000/status/failed > tts-failed.json"
Open3.popen2e(cmd) do |stdin, stdout_err, wait_thr|
  while line = stdout_err.gets
    puts "#{line}"
  end

  exit_status = wait_thr.value
  unless exit_status.success?
    puts '---------------------'
    puts "FAILED to execute --> #{cmd}"
    puts '---------------------'
  end
end

file = File.open('tts-failed.json', 'r')
data = JSON.load file
file.close

cmd = "rm tts-failed.json"
Open3.popen2e(cmd) do |stdin, stdout_err, wait_thr|
  while line = stdout_err.gets
    puts "#{line}"
  end

  exit_status = wait_thr.value
  unless exit_status.success?
    puts '---------------------'
    puts "FAILED to execute --> #{cmd}"
    puts '---------------------'
  end
end

i = 0
myarray = []

while i < data.length
  value = {"id" => "#{data[i]['id']}", 
           "record_id" => "#{data[i]['record_id']}", 
           "service" => "#{data[i]['service']}", 
           "status" => "#{data[i]['status']}", 
           "caption_locale" => "#{data[i]['caption_locale']}", 
           "processtime" => "#{data[i]['processtime']}", 
           "error" => "#{data[i]['error']}", 
           "start_time" => "#{data[i]['start_time']}",
           "end_time" => "#{data[i]['end_time']}"
         }
  myarray[i] = value
  i += 1
end

tp myarray, :include => [:record_id => {:width => 60}, :status => {:width => 60}]
