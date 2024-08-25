require 'sinatra'
require 'erb'

task_list = []
id_counter = 1

get '/' do
@tasks = task_list
erb :index
end

post '/add' do
task_list << {id: id_counter, name: params[:task], due_date: params[:due_date]}
id_counter += 1
redirect '/'
end

post '/delete/:id' do
task_list.reject! { |task| task[:id] == params[:id].to_i }
redirect '/'
end