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
        movements << Movement31.new(data_31) if data_31_required?
        movements << Movement32.new(data_32) if data_32_required?
        movements << Movement33.new(data_33) if data_33_required?
        movements
      end

      def data_21
        next_code = data_22_required? || data_23_required?
        data.merge(
          communication: communication(2, 0, Movement21::COMM_LENGTH),
          next_code: next_code,
          link_code: !next_code && data_31_required?
        ).compact
      end

      def data_22_required?
        return true if Movement22.required?(data, ignore: Movement22::SHARED)

        !!communication_22
      end

      def communication_22
        communication(2, Movement21::COMM_LENGTH, Movement22::COMM_LENGTH)
      end

      def data_22
        next_code = data_23_required?
        data.merge(
          communication: communication_22,
          next_code: next_code,
          link_code: !next_code && data_31_required?
        )
      end

      def data_23_required?
        return true if Movement23.required?(data, ignore: Movement23::SHARED)

        !!communication_23
      end

      def communication_23
        communication(2, Movement21::COMM_LENGTH + Movement22::COMM_LENGTH, Movement23::COMM_LENGTH)
      end

      def data_23
        data.merge(
          communication: communication_23,
          link_code: data_31_required?
        )
      end

      def data_31_required?
        return false unless normalized_communication[:structured]
        return false unless normalized_communication[:unstructured]

        !normalized_communication[:unstructured].empty?
      end

      def communication_31
        communication(3, 0, Movement31::COMM_LENGTH)
      end

      def data_31
        data.merge(
          communication: communication_31,
          next_code: data_32_required? || data_33_required?
        )
      end

      def data_32_required?
        return false unless normalized_communication[:structured]
        return false unless normalized_communication[:unstructured]

        !!communication_32
      end

      def communication_32
        communication(3, Movement31::COMM_LENGTH, Movement32::COMM_LENGTH)
      end

      def data_32
        data.merge(
          communication: communication_32,
          next_code: data_33_required?
        )
      end

      def data_33_required?
        return false unless normalized_communication[:structured]
        return false unless normalized_communication[:unstructured]

        !!communication_33
      end

      def communication_33
        communication(3, Movement31::COMM_LENGTH + Movement32::COMM_LENGTH, Movement33::COMM_LENGTH)
      end

      def data_33
        data.merge(communication: communication_33)
      end

      def communication(level, from, max_length)
        communication = normalized_communication
        which = if level == 2
                  communication[:structured] ? :structured : :unstructured
                else
                  :unstructured
                end
        communication = communication.slice(which)
        communication[which] = communication[which][from...(from + max_length)].to_s
        communication[which] = nil if communication[which].empty?
        communication = communication.compact
        communication.empty? ? nil : communication
      end

      def normalized_communication
        @normalized_communication ||= begin
          communication = data[:communication]
          case communication
          when NilClass
            { unstructured: '' }
          when String
            { unstructured: communication }
          when Hash
            communication = { unstructured: '' } if communication.empty?
            communication
          else
            check!(false, "Unexpected communication #{communication}")
          end
        end
      end
    end
  end
end
