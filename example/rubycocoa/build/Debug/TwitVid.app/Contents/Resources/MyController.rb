# RubyController

require 'osx/cocoa'
require '/Users/fastshop/Desktop/ruby/phtwitvid/lib/phtwitvid.rb'

class RubyController < OSX::NSObject

  ib_outlets :tf_username, :tf_password, :tf_path, :tf_description, :radio, :tf_source, :spinner;
  
  ib_action :btnClicked do |sender|
    @spinner.startAnimation 0
    uploadVideo(@tf_username.stringValue, @tf_password.stringValue, @tf_path.stringValue, @tf_description.stringValue, @tf_source.stringValue)
	  @spinner.stopAnimation 0
  end
  
  def uploadVideo(username, password, path, description, source)  
	twitvid = PHTwitVid.new();
	token = twitvid.get_token(username, password)
	if token == 'Invalid username/password'
		show_alert("Error", "Invalid username or password");
	else
	video = twitvid.upload(token, description, path, 'upload', source)	
	show_alert("Success", "Your video was successfully uploaded!\nVideo URL: #{video['media_url']}")
	end
	end
	
  def show_alert(title, message)
	alert = OSX::NSAlert.alloc.init;
	alert.setMessageText(title)
	alert.setInformativeText(message);
	alert.setAlertStyle(OSX::NSInformationalAlertStyle)
	alert.beginSheetModalForWindow(@mainWindow,:modalDelegate, self,:didEndSelector, nil,:contextInfo, nil)
	end

end
