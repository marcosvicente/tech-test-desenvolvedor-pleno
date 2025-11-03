class UploadFilesController < ApplicationController
  def index
    @upload_files = UploadEmail.order(created_at: :desc).page(params[:page])
  end

  def new
    @upload_files = UploadEmail.new
  end

  def create
    # UploadFile::ProcessorEmailService.call(filename: upload_file_params[:filename])
    UploadParserJob.perform_async(filename: upload_file_params[:filename])
    redirect_to upload_files_path, notice: 'File send and upload started.'

  rescue => e
    redirect_to new_upload_file_path, alert: "Fail in upload: #{e.message}"
  end

  private

  def upload_file_params
      params.require(:upload_email).permit(
      :filename,
    )
  end
end


