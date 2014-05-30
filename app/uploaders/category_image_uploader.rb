class CategoryImageUploader < AttachmentUploader

  process :resize_to_fit => [450, 300]

  def extension_white_list
    %w(jpg jpeg png)
  end
end
