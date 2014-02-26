class Document < Attachment
  mount_uploader :file, DocumentUploader

  validates :title, presence: true
  validates :file, file_size: { maximum: 15.megabytes }
end
