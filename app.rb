require 'sinatra' # Sinatra web server
require 'erb' # Ruby templates
require 'date' # date parser

class TaskList < Sinatra::Base # task list class
  task_list = [] # set initial task list to empty array
  id_counter = 1 # set initial id counter to 1

  def overdue?(due_date) # check if task is overdue
    Date.parse(due_date) < Date.today # parse the date string
  end

  get '/' do # get task list
    @tasks = task_list # set tasks to task list array
    erb :index # redirect to index page
  end

  post '/add' do # add task to task list
    task_list << { id: id_counter, name: params[:task], due_date: params[:due_date] } # add task to task list
    id_counter += 1 # increase id counter by 1 when task is added
    redirect '/' # redirect to index page
  end

  post '/delete/:id' do
    task_list.reject! { |task| task[:id] == params[:id].to_i } # find task to delete by task id
    redirect '/' # redirect to index page
  end
end

TaskList.run! # run the task list application
