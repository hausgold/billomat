# frozen_string_literal: true

module Billomat
  module Models
    ##
    # Representation of the invoice resource
    class Invoice < Base
      # @return [String] The resource's base path
      def self.base_path
        '/invoices'
      end

      # @return [String] The resource's name
      def self.resource_name
        'invoice'
      end

      ##
      # Completes the invoice by calling the Complete action
      def complete!
        Billomat::Actions::Complete.new(id).call
      end

      ##
      # Cancels the invoice by calling the Cancel action
      def cancel!
        Billomat::Actions::Cancel.new(id).call
      end

      ##
      # Sends the invoice as an email to the given recipient
      #
      # @param [String] recipient The email address of the recipient
      def send_email(recipient)
        email_params = { recipients: { to: recipient } }

        Billomat::Actions::Email.new(id, email_params).call
      end

      ##
      # Allows to download the invoice as an PDF
      def to_pdf
        Billomat::Actions::Pdf.new(id).call
      end
    end
  end
end
