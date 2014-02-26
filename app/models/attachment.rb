# Attachment:
#
#   title,  string
#   locale, string
#
#   file,      carrierwave file
#   file_meta, hash, keys - size, mime-type [, width, height].
#
#   attachable_type, string
#   attachable_id,   integer
#
#   created_at, datetime
#
class Attachment
  include Mongoid::Document
  include Mongoid::Timestamps
  # belongs_to :attachable, polymorphic: true
  embedded_in :attachable, polymorphic: true

  field :file_meta, type: Hash
  field :title, type: String

  # serialize :file_meta, JSON

  validates_presence_of :file

  before_validation :set_defaults
  before_validation :set_file_meta

  def name
    File.basename(file.path, ext)
  end

  def ext
    File.extname(file.path)
  end

  def simple_ext
    ext.split('.').reject(&:blank?).last
  end

  def type
    file_meta['type']
  end

  def common_type
    case ext
    when /jpg|jpeg|png/
      :image
    when /zip|rar|gz|bz2|7z/
      :archive
    when /pdf|odf|odt|rtf|doc|docx|xls|xlsx/
      :document
    when /ppt|pptx/
      :slides
    when /avi|mp4|flv|mkv/
      :video
    end
  end

  def size
    file_meta['size']
  end

  protected
    def set_defaults
      self.title = file.filename if title.blank? and file.present?
      # self.locale = I18n.locale
    end

    def set_file_meta
      self.file_meta = file.meta if :file_changed?
    end
end
