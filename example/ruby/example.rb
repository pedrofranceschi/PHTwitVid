require 'lib/phtwitvid.rb'

puts "TwitVid Username: "
username = gets.chomp
puts
puts "TwitVid Password: "
password = gets.chomp
puts
twitvid = PHTwitVid.new
myToken = twitvid.get_token(username, password)
puts "Your Token is #{myToken}"
puts
puts "Please drag a video here to upload: "
video_path = gets.chomp
puts
puts "Please type the video description"
description = gets.chomp
puts
puts "Do you want to upload and tweet a message with the video URL (YES or NO)?"
uploadAndPost = gets.chomp
if uploadAndPost == "YES"
  type = "uploadAndPost"
else
  type = "upload"
end
puts
puts
puts "We are uploading your video..."
video_url = twitvid.upload(myToken, description, video_path, type, '<a href=http://github.com/pedrofranceschi/PHTwitVid>PHTwitVid</a>')
puts
puts "Your Video was successfully uploaded!"
puts "Video URL: #{video_url['media_url']}"