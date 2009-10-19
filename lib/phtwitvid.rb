#!/usr/bin/ruby
require 'rubygems'
require 'httparty'
require 'xmlsimple'
require 'mechanize'
require 'open-uri'

class PHTwitVid
  
  def initialize
    $api_url = "https://im.twitvid.com/api"
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
  
  def upload(token, message, video_path, post, source)
    f = File.new(video_path, File::RDWR)
    agent = WWW::Mechanize.new
    response = agent.post(
        "#{$api_url}/#{post}",
        {
             :media      =>  f,
             :token      =>  token,
             :message    =>  message,
             :source     =>  source
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
  
  def create_playlist(token, playlist_name)
    params = { :query => {:token => token, :playlistName => playlist_name}}
    response = HTTParty.post("#{$api_url}/createPlaylist", params)
    xml = XmlSimple.xml_in(response.body, { 'KeyAttr' => 'name' })
    return {'playlist_url' => xml['playlist_url'].to_s, 'playlist_id' => xml['playlist_id'].to_s}
  end
  
  def get_uploaded_videos(token)
    params = { :query => {:token => token}}
    response = HTTParty.post("#{$api_url}/getVideos", params)
    return response.body
  end
  
  def get_thumbnail_url(video_id)
    return "http://cdn.twitvid.com/thumbnails/#{video_id}.jpg"
  end
  
  def profile(username)
    unparsed_xml = open("http://www.twitter.com/users/show.xml?screen_name=#{username}");
    xml = XmlSimple.xml_in(unparsed_xml, { 'KeyAttr' => 'name' })
    return {'id' => xml['id'].to_s, 'name' => xml['name'].to_s, 'screen_name' => xml['screen_name'].to_s, 'location' => xml['location'].to_s,
            'description' => xml['description'].to_s, 'url' => xml['url'].to_s, 'profile_image_url' => xml['profile_image_url'].to_s,
            'followers' => xml['followers_count'].to_s, 'following' => xml['friends_count'].to_s, }
  end
    
end