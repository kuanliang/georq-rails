require 'data_file'
require 'zip'
class UploadController < ApplicationController
   before_action :authenticate_user!, only: [:new,:index, :edit, :create, :update, :destroy] 
  def initialize
    
  end

  def index
  	if params[:id]
    	 mime_type = 
      "application/vnd.openxmlformats-
      officedocument.wordprocessingml.document"
    
    DataFile.save(params[:upload],params[:upload1],params[:upload2])
    
     Send the new file with the wordprocessingml document
     content type.
    send_file("#{RAILS_ROOT}/public/resources/newdoc.docx",
      :filename=> "newdoc.docx",
      :type=>mime_type)
    else 
    	render :file=> 'app\\views\\uploadfile.rhtml'
    end
  end

  def uploadfile
   
  end
  def create
  	 mime_type = 
      "application/vnd.openxmlformats-
      officedocument.wordprocessingml.document"
    
    DataFile.save(params[:upload],params[:upload1],params[:upload2])
    
     Send the new file with the wordprocessingml document
     content type.
    send_file("#{RAILS_ROOT}/public/resources/newdoc.docx",
      :filename=> "newdoc.docx",
      :type=>mime_type)
  end

end
