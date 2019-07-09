class CaptionsController < ApplicationController
    def index
        puts "Hello World!"
    end
    
    def service
        @service = params[:service]
        @recordID = params[:recordID]
        
        puts "#{@service} #{@recordID}"
        
       if(params[:service] === "google")
            system("bin/rails runner ./ruby_files/text-track-service.rb #{@service} /D/innovation/text-track-service #{@recordID} <put api key here> bbb-accessibility")
       elsif(params[:service] === "ibm")
           system("bin/rails runner ./ruby_files/text-track-service.rb #{@service} /D/innovation/text-track-service #{@recordID} <put api key here>")
       elsif(params[:service] === "deepspeech")
           system("bin/rails runner ./ruby_files/text-track-service.rb #{@service} /D/innovation/text-track-service #{@recordID} <put deepspeech model path here>")
       elsif(params[:service] === "speechmatics")
           system("bin/rails runner ./ruby_files/text-track-service.rb #{@service} /D/innovation/text-track-service #{@recordID} <put user id here> <put api key here>")
       else
           puts "No such service found"
       end
        
    end
    
    def progress
        @captions = Caption.all
        
        tp @captions
    end
    
    def progress_id
        @recordID = params[:id]
        @caption = Caption.where(recordID: @recordID)
        tp @caption
    end
    
    private
        def find_record_by_id
            @captionfile = Captions.find(params[:id])
        end
    
end
