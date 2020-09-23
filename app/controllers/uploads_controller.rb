class UploadsController < ApplicationController
  before_filter :authenticate_admin

  def index
    @upload = Upload.new
    @uploads = Upload.all
  end

  def create
    @upload = Upload.new(upload_params)

    flash[:danger] = @upload.errors.full_messages.to_sentence unless @upload.save
    redirect_to uploads_path
  end

  def download
    upload = Upload.find(params[:id])
    send_file upload.file.path, :x_sendfile=>true
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy
    redirect_to uploads_path
  end

  private

  def upload_params
    params.require(:upload).permit(:name, :description, :public, :file)
  end
end
