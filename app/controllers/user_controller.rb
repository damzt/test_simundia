class UserController < ApplicationController


  def new
  end

  def upload_file

    require 'csv'

    logger.info("Upload email csv file.")

    begin

      import_params = { file_data: params[:csv_file] }

      Upload.import_data(import_params)

      flash[:notice] = "Email file successfully uploaded. You can find the generated CSV file in tmp folder."
      redirect_to :action => 'new'

    rescue => e

     logger.info("Upload User Error :  #{e}")
     flash[:notice] = "Uploading data failed : #{e}"
     redirect_to :action => 'new'

    end

    logger.info("End uploading email csv file.")

  end

end
