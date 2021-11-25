module Codabel
  class Record
    class Trailer < Record
      FOLLOWING = { when_true: '1', when_false: '2' }.freeze

      column 1..1,     nil,              Type::N,                     default: 9
      column 2..16,    nil,              Type::AN,                    default: ''
      column 17..22,   :records_count,   Type::N,                     default: 0
      column 23..37,   :debit,           Type::Amount,                default: 0
      column 38..52,   :credit,          Type::Amount,                default: 0
      column 53..127,  nil,              Type::AN,                    default: ''
      column 128..128, :file_follows,    Type::Flag.new(**FOLLOWING), default: false

      def auto_enrich(file)
        enriched = data.merge(
          records_count: data[:records_count] || count_records(file),
          debit: data[:debit] || sum_debit(file),
          credit: data[:credit] || sum_credit(file)
        )
        Trailer.new(enriched)
      end

      private

      def count_records(file)
        file.records.filter { |record| must_be_counted?(record) }.size
      end

      def must_be_counted?(record)
        !(record.is_a?(Header) || record.is_a?(Trailer))
      end

      def sum_debit(file)
        movements21(file).map(&:debit_amount).sum.abs
      end

      def sum_credit(file)
        movements21(file).map(&:credit_amount).sum.abs
      end

      def movements21(file)
        file.records.filter { |record| record.is_a?(Movement21) }
      end
    end
  end
end
