require "sinatra" # Sinatra web server
require "erb" # Ruby templates
require "date" # date parser

class TaskList < Sinatra::Base
  task_list = []
  id_counter = 1

  def overdue?(due_date) #function to check if task is overdue
    Date.parse(due_date) < Date.today #parse the date string
  end

  get "/" do #get request from index page (home page)
    @tasks = task_list #set tasks to task list array
    erb :index #redirect to index page (home page)
  end

  post "/add" do #post request to add task to task list
    task_list << { id: id_counter, name: params[:task], due_date: params[:due_date] } #add task based on entered form inputs
    id_counter += 1 #increase id counter by 1 when task is added
    redirect "/" #redirect to index page (home page)
  end

  post "/delete/:id" do #post request to delete task from task id
    task_list.reject! { |task| task[:id] == params[:id].to_i } #find task to deleet based on task id
    redirect "/" #redirect to index page (home page)
  end
end

TaskList.run! #run the task list application
