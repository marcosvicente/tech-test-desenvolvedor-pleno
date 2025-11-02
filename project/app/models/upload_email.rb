class UploadEmail < ApplicationRecord
  belongs_to :customer, optional: true
  has_one_attached :filename

  STATUSES = %w[queueding processing failed done].freeze

  validates :filename, presence: true
  validates :status, inclusion: { in: STATUSES }

  def queueding?
    status == 'queueding'
  end
  def processing?
    status == 'processing'
  end

  def failed?
    status == 'failed'
  end

  def done?
    status == 'done'
  end
end
