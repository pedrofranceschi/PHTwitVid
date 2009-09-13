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
    return {'media_url' => xml['media_url'].to_s, 'media_id' => xml['media_id'].to_s}
  end
  
  def delete(token, video_id)
    params = { :query => {:token => token, :media_id => video_id}}
    response = HTTParty.post("#{$api_url}/delete", params)
    xml = XmlSimple.xml_in(response.body, { 'KeyAttr' => 'name' })
    return xml['rsp stat']
  end
  
  def embed(video_id, width, height)
    if width == nil || height == nil
      width = '425'
      height = '344'
    end
    return "<object width=\"#{width}\" height=\"#{height}\">
         <param name=\"movie\" value=\"http://www.twitvid.com/player/#{video_id}>\"></param>
         <param name=\"allowFullScreen\" value=\"true\"></param>
         <embed type=\"application/x-shockwave-flash\" src=\"http://www.twitvid.com/player/#{video_id}\" quality=\"high\" allowscriptaccess=\"always\" allowNetworking=\"all\"      allowfullscreen=\"true\" wmode=\"transparent\" height=\"#{height}\" width=\"#{width}\">
    </object>"
  end
      
end