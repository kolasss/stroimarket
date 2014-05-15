class HeaderUploader < AttachmentUploader

  process :resize_to_fill => [1000, 250]

  def extension_white_list
    %w(jpg jpeg png)
  end
end
