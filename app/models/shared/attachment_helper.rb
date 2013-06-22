module Shared
  module AttachmentHelper

    class << self
      def included(base)
        base.extend ClassMethods
      end
    end

    module ClassMethods
      def has_attachment(name, options = {})

        # generates a string containing the singular model name and the pluralized attachment name.
        # Examples: "user_avatars" or "asset_uploads" or "message_previews"
        attachment_owner    = self.table_name.singularize
        attachment_folder   = "#{attachment_owner}_#{name.to_s.pluralize}"

        # we want to create a path for the upload that looks like:
        # message_previews/00/11/22/001122deadbeef/thumbnail.png
        attachment_path     = "/vinotkAdmin/:attachment/:id/:style/:filename"
#{attachment_folder}/:uuid_partition/:uuid/:style.:extension"

        if Rails.env.production?
          options[:path]            ||= attachment_path
          options[:storage]         ||= :ftp
          options[:url]             ||= 'http://esampaio.free.fr/vinotkAdmin/:attachment/:id/:style/:filename'
          options[:ftp_servers]     ||= [{
                                          :host     => "ftpperso.free.fr",
                                          :user     => "esampaio",
                                          :password => "thditfq",
                                          :passive  => true
                                          }
                                         ]
        else
          # For local Dev/Test envs, use the default filesystem, but separate the environments
          # into different folders, so you can delete test files without breaking dev files.
          #options[:path]  ||= ":rails_root/public/system/attachments/#{Rails.env}/#{attachment_path}"
          #options[:url]   ||= "/system/attachments/#{Rails.env}/#{attachment_path}"

          options[:path]            ||= attachment_path
          options[:storage]         ||= :ftp
          options[:url]             ||= 'http://esampaio.free.fr/vinotkAdmin/:attachment/:id/:style/:filename'
          options[:ftp_servers]     ||= [{
                                             :host     => "ftpperso.free.fr",
                                             :user     => "esampaio",
                                             :password => "thditfq",
                                             :passive  => true
                                         }
          ]


        end

        # pass things off to paperclip.
        has_attached_file name, options
      end
    end
  end
end