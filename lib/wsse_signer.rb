# frozen_string_literal: true

require "wsse_signer/signer"

module WsseSigner
  def self.signer(document, noblanks: true, wss: true, canonicalize_algorithm: :c14n_exec_1_0)
    Signer.new(document, noblanks: noblanks, wss: wss, canonicalize_algorithm: canonicalize_algorithm)
  end
end
