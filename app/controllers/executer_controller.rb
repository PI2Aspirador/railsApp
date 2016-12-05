require 'executer.rb'
class ExecuterController < ApplicationController


  def index
    @cmd = true
    @command = params[:command]
    script = File.expand_path("execute.sh")
    puts script
    puts @command
    case params[:command]
    when '1'
      puts "1"
      system(script+' '+@command)

    when '2'
      system(script+' '+@command)
    else
      puts "DEU RUIM******************"
    end
  end
end
