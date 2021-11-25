module Codabel
  class Error < StandardError; end
  class ValidationError < Error; end
  class TypeError < Error; end
end
