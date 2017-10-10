module ApiResponse
  module Publishers
    class Index
      def initialize(publishers)
        @publishers = publishers
      end

      def to_h
        data = [].tap do |collection|
          @publishers.each do |element|
            collection << publisher_as_hash(element)
          end
        end

        { count: data.count, data: data }
      end

      private

      def publisher_as_hash(publisehr)
        {
          id: publisehr.id,
          name: publisehr.name,
          email: publisehr.email,
          phone: publisehr.phone,
          congregationMember: publisehr.congregation_member?,
        }
      end
    end
  end
end

