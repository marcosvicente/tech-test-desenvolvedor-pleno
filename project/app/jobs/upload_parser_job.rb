class UploadParserJob < ApplicationJob
  queue_as :default
  def perform(filename: )
    UploadFile::ProcessorEmailService.call(filename: filename)
  end
end
