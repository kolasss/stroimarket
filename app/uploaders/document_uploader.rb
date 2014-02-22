class DocumentUploader < AttachmentUploader
  def extension_white_list
    %w[
      zip rar gz bz2 7z
      pdf odf odt rtf doc docx xls xlsx
      ppt pptx
      jpg jpeg png
      avi mp4 flv mkv
    ]
  end
end
