# frozen_string_literal: true

require 'openssl'

module WsseSigner
  # Class that holds +OpenSSL::Digest+ instance with some meta information for digesting in XML.
  class Digester
    DIGEST_ALGORITHMS = {
      # SHA 1
      sha1: {
        name: 'SHA1',
        id: 'http://www.w3.org/2000/09/xmldsig#sha1',
        digester: -> { OpenSSL::Digest::SHA1.new }
      },
      # SHA 256
      sha256: {
        name: 'SHA256',
        id: 'http://www.w3.org/2001/04/xmlenc#sha256',
        digester: -> { OpenSSL::Digest::SHA256.new }
      },
      # SHA512
      sha512: {
        name: 'SHA512',
        id: 'http://www.w3.org/2001/04/xmlenc#sha512',
        digester: -> { OpenSSL::Digest::SHA512.new }
      },
      # GOST R 34-11 94
      gostr3411: {
        name: 'GOST R 34.11-94',
        id: 'http://www.w3.org/2001/04/xmldsig-more#gostr3411',
        digester: -> { OpenSSL::Digest.new('md_gost94') }
      },
      # GOST R 34-11 2012 256 bit
      gostr34112012_256: {
        name: 'GOST R 34.11-2012 256',
        id: 'urn:ietf:params:xml:ns:cpxmlsec:algorithms:gostr34112012-256',
        digester: lambda {
                    begin begin
                                   OpenSSL::Digest.new('streebog256')
                          rescue StandardError
                            OpenSSL::Digest.new('md_gost12_256')
                                 end end
                  }
      }
    }.freeze

    # You may pass either a one of +:sha1+, +:sha256+ or +:gostr3411+ symbols
    # or +Hash+ with keys +:id+ with a string, which will denote algorithm in XML Reference tag
    # and +:digester+ with instance of class with interface compatible with +OpenSSL::Digest+ class.
    def initialize(algorithm)
      if algorithm.is_a? Symbol
        @digest_info = DIGEST_ALGORITHMS[algorithm].dup
        @digest_info[:digester] = @digest_info[:digester].call
        @symbol = algorithm
      else
        @digest_info = algorithm
      end
    end

    attr_reader :symbol

    # Digest
    def digest(message)
      digester.digest(message)
    end

    alias call digest

    # Returns +OpenSSL::Digest+ (or derived class) instance
    def digester
      @digest_info[:digester].reset
    end

    # Human-friendly name
    def digest_name
      @digest_info[:name]
    end

    # XML-friendly name (for specifying in XML +DigestMethod+ node +Algorithm+ attribute)
    def digest_id
      @digest_info[:id]
    end
  end
end
