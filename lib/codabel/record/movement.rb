module Codabel
  class Record
    class Movement < Record
      def to_coda
        actual_movements.map(&:to_coda).join("\n")
      end

      def actual_records(_file)
        actual_movements
      end

      private

      def actual_movements
        movements = []
        movements << Movement21.new(data_21)
        movements << Movement22.new(data_22) if data_22_required?
        movements << Movement23.new(data_23) if data_23_required?
        movements
      end

      def data_21
        data.merge(
          communication: communication(0, Movement21::COMM_LENGTH),
          next_code: data_22_required? || data_23_required?
        ).compact
      end

      def data_22_required?
        return true if Movement22.required?(data, ignore: Movement22::SHARED)

        !!communication_22
      end

      def communication_22
        communication(Movement21::COMM_LENGTH, Movement22::COMM_LENGTH)
      end

      def data_22
        data.merge(
          communication: communication_22,
          next_code: data_23_required?
        )
      end

      def data_23_required?
        return true if Movement23.required?(data, ignore: Movement23::SHARED)

        !!communication_23
      end

      def communication_23
        communication(Movement21::COMM_LENGTH + Movement22::COMM_LENGTH, Movement23::COMM_LENGTH)
      end

      def data_23
        data.merge(communication: communication_23)
      end

      def communication(from, max_length)
        return nil unless data[:communication]
        return nil if data[:communication].length < from

        comm = data[:communication][from...(from + max_length)]
        comm.empty? ? nil : comm
      end
    end
  end
end
