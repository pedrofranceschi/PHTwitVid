require 'rubygems'
require 'httparty'
require 'xmlsimple'
require 'mechanize'

class PHTwitVid
  
  $api_url = "https://im.twitvid.com/api"
  
  def initialize
  end
  
  def get_token(username, password)
    params = { :query => {:username => username, :password => password}}
    response = HTTParty.post("#{$api_url}/authenticate", params)
    xml = XmlSimple.xml_in(response.body, { 'KeyAttr' => 'name' })
    if xml['token'] == nil
      return "Invalid username/password"
    else
    return xml['token']
  end
  end
  
  def upload(token, message, video_path, post)  
    f = File.new(video_path, File::RDWR)
    agent = WWW::Mechanize.new
    response = agent.post(
        "#{$api_url}/#{post}",
        {
             :media      =>  f,
             :token      =>  token,
             :message    =>  message
        }
    )
    f.close
    xml = XmlSimple.xml_in(response.body, { 'KeyAttr' => 'name' })
    return xml['media_url']
  end
        
end