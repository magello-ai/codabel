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

        additional_communications.each_with_index do |_, index|
          movements << Movement31.new(data_31(index)) if data_31_required?(index)
          movements << Movement32.new(data_32(index)) if data_32_required?(index)
          movements << Movement33.new(data_33(index)) if data_33_required?(index)
        end

        movements
      end

      def data_21
        next_code = data_22_required? || data_23_required?

        data.merge(
          communication: communication_content(main_communication, 0, Movement21::COMM_LENGTH),
          next_code: next_code,
          link_code: !next_code && data_31_required?
        ).compact
      end

      def data_22_required?
        return true if Movement22.required?(data, ignore: Movement22::SHARED)

        !!communication_22
      end

      def communication_22
        communication_content(main_communication, Movement21::COMM_LENGTH, Movement22::COMM_LENGTH)
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
        communication_content(main_communication, Movement21::COMM_LENGTH + Movement22::COMM_LENGTH, Movement23::COMM_LENGTH)
      end

      def data_23
        data.merge(
          communication: communication_23,
          link_code: data_31_required?
        )
      end

      def data_31_required?(index = 0)
        additional_communications.size > index
      end

      def communication_31(record_index)
        communication_content(
          additional_communications[record_index],
          0,
          Movement31::COMM_LENGTH
        )
      end

      def data_31(record_index)
        next_code = data_32_required?(record_index) || data_33_required?(record_index)
        communication = communication_31(record_index)

        data.merge(
          communication: communication,
          next_code: next_code,
          link_code: !next_code && data_31_required?(record_index + 1)
        )
      end

      def data_32_required?(record_index)
        !!communication_32(record_index)
      end

      def communication_32(record_index)
        communication_content(
          additional_communications[record_index],
          Movement31::COMM_LENGTH,
          Movement32::COMM_LENGTH,
        )
      end

      def data_32(record_index)
        next_code = data_33_required?(record_index)

        data.merge(
          communication: communication_32(record_index),
          next_code: next_code,
          link_code: !next_code && data_31_required?(record_index + 1)
        )
      end

      def data_33_required?(record_index)
        !!communication_33(record_index)
      end

      def communication_33(record_index)
        communication_content(
          additional_communications[record_index],
          Movement31::COMM_LENGTH + Movement32::COMM_LENGTH,
          Movement33::COMM_LENGTH
        )
      end

      def data_33(record_index)
        data.merge(
          communication: communication_33(record_index),
          link_code: data_31_required?(record_index + 1)
        )
      end

      def main_communication
        return data[:communication] unless data[:communication].is_a?(Hash)

        if data[:communication].key?(:structured)
          data[:communication].slice(:structured, :structured_code)
        else
          data[:communication].slice(:unstructured)
        end
      end

      def additional_communications
        # Legacy support for structured + unstructured communication
        communication = normalized(data[:communication])

        if [:structured, :unstructured].all? { |key| communication.key?(key) }
          return [communication.slice(:unstructured), *data[:additional_communications]]
        end

        data[:additional_communications] || []
      end

      def communication_content(communication, from, max_length)
        communication = normalized(communication)

        which = communication[:structured] ? :structured : :unstructured

        content =
          if which == :structured
            communication.slice(:structured, :structured_code)
          else
            communication.slice(:unstructured)
          end

        content[which] = split_communication(content, which, from, max_length)

        return nil if content[which].empty?

        content
      end

      def split_communication(communication, which, from, max_length)
        if which == :structured
          # Take into account the size of the structured code in communication splitting
          max_length -= 3 # Remove 3 chars at the end of the structured communication
          from = [from - 3, 0].max # and make sure to find them back at the next line
        end

        communication[which][from...(from + max_length)].to_s
      end

      def normalized(communication)
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
