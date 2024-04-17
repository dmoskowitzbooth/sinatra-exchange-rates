require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
 
  curr_key=ENV["EXCHANGE_RATE_KEY"]
  curr_list="https://api.exchangerate.host/list?access_key=#{curr_key}"
  curr=HTTP.get(curr_list)
  curr_parsed=JSON.parse(curr)
  @curr_results=curr_parsed["currencies"].keys

  erb(:home)
end

get("/:a_curr") do
  @cfrom=params.fetch("a_curr").to_s

  curr_key=ENV["EXCHANGE_RATE_KEY"]
  curr_list="https://api.exchangerate.host/list?access_key=#{curr_key}"
  curr=HTTP.get(curr_list)
  curr_parsed=JSON.parse(curr)
  @curr_results=curr_parsed["currencies"].keys

 erb(:convert)
end

get("/:cfrom/:cto") do
  @cfrom=params.fetch("cfrom").to_s
  @cto=params.fetch("cto").to_s

  curr_key=ENV["EXCHANGE_RATE_KEY"]
  curr_list="https://api.exchangerate.host/list?access_key=#{curr_key}"
  curr=HTTP.get(curr_list)
  curr_parsed=JSON.parse(curr)
  @curr_results=curr_parsed["currencies"].keys

 @con_url= "https://api.exchangerate.host/convert?access_key=#{curr_key}&from=#{@cfrom}&to=#{@cto}&amount=1"

 conversion=HTTP.get(@con_url)
 conversion_parsed=JSON.parse(conversion)
 @conversion_result=conversion_parsed["result"]

 
 
  
 erb(:result)
end
