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

get("/:a_curr/:cfrom") do
  @cfrom=params.fetch("a_curr").to_s

  curr_key=ENV["EXCHANGE_RATE_KEY"]
  curr_list="https://api.exchangerate.host/list?access_key=#{curr_key}"
  curr=HTTP.get(curr_list)
  curr_parsed=JSON.parse(curr)
  @curr_results=curr_parsed["currencies"].keys
  
 erb(:convert)
end
