module Codabel
  class Type
    class AccountDescription < Type
      def to_coda(value, length)
        description = Model::Account.dress(value).description
        description.to_s.ljust(length, ' ')
      end
    end
  end
end
