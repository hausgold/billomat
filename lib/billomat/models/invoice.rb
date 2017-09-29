# frozen_string_literal: true

module Billomat
  module Models
    class Invoice < Base
      def self.base_path
        '/invoices'
      end

      def self.resource_name
        'invoice'
      end

      def complete!
        Billomat::Actions::Complete.new(id).call
      end

      def send_email(recipient)
        email_params = { recipients: { to: recipient } }

        Billomat::Actions::Email.new(id, email_params).call
      end

      def to_pdf
        Billomat::Actions::Pdf.new(id).call
      end
    end
  end
end
