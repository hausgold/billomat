# frozen_string_literal: true

module Billomat
  # This class provides the possibility utility functions for data formatting
  class Utils
    # @param [Hash] resp The response from the gateway
    # @return [Integer] the number of records found
    def self.count(resp, name)
      return 0 if resp.nil?

      resp["#{name}s"]['@total'].to_i
    end

    # Corrects the response to always return an array.
    #
    # @todo Due to a strange API behaviour we have to fix the reponse here.
    #   This may be fixed in a new API version.
    #
    # @param [Hash] resp The response from the gateway
    # @param [String] name The name of the resource
    # @param [Class] resource The resource class to be queried
    # @return [Array<Billomat::Model::Base>]
    def self.to_array(resp, name, resource)
      case count(resp, name)
      when 0
        []
      when 1
        # Necessary due to strange API behaviour
        [resource.new(resp["#{name}s"][name])]
      else
        resp["#{name}s"][name].map do |c|
          resource.new(c)
        end
      end
    end

    # @param [Hash] resp The response from the gateway
    # @param [String] name The name of the resource
    # @return [Hash] The paging info (page, per_page and total)
    def self.get_paging_data(resp, name)
      page = resp["#{name}s"]['@page'].to_i
      per_page = resp["#{name}s"]['@per_page'].to_i
      total = resp["#{name}s"]['@total'].to_i

      {
        'page' => page,
        'per_page' => per_page,
        'total' => total
      }
    end

    # @param [Hash] paging_data The response from get_paging_data
    def self.out_of_bounds(paging_data)
      if paging_data['total'].zero?
        true
      elsif paging_data['page'] == 1
        false
      else
        shown = (paging_data['page'] - 1) * paging_data['per_page']
        shown > paging_data['total']
      end
    end
  end
end
