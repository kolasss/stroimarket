class LogoUploader < AttachmentUploader

  process :resize_to_fill => [98, 98]

  def extension_white_list
    %w(jpg jpeg png)
  end
end
