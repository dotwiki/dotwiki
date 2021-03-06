# frozen_string_literal: true

# Skeleton for this file was generated by `bin/rails generate oneshot add_shotcode_to_attachments`
# For copy and paste: `bin/rake oneshot:add_shotcode_to_attachments_20200210`
namespace :oneshot do
  desc ''
  task add_shotcode_to_attachments_20200210: :environment do
    Attachment.all.each do |att|
      if att.shortcode.nil?
        att.update!(shortcode: "#{att.class.name}#{att.id}")
      end
    end
  end
end
