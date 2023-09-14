require 'rails_helper'

RSpec.describe BreakdownSerializer do
  describe '#as_json' do

    it "cleans format" do
      message = "1. Sort laundry by color and fabric type.\n2. Start the washing machine with appropriate settings and detergent.\n3. Transfer clothes to dryer or hang them to air dry.\n4. Fold and organize laundry by category.\n5. Put away folded laundry in their designated spots."
      serializer = BreakdownSerializer.new(message)

      result = serializer.clean_message
      expect(result).to eq("1. Sort laundry by color and fabric type. 2. Start the washing machine with appropriate settings and detergent. 3. Transfer clothes to dryer or hang them to air dry. 4. Fold and organize laundry by category. 5. Put away folded laundry in their designated spots.")
    end

    it 'returns the correct JSON structure' do
      message = "1. Sort laundry by color and fabric type.\n2. Start the washing machine with appropriate settings and detergent.\n3. Transfer clothes to dryer or hang them to air dry.\n4. Fold and organize laundry by category.\n5. Put away folded laundry in their designated spots."
      serializer = BreakdownSerializer.new(message)

      result = serializer.as_json

      expect(result).to eq(
        {
          "response": [
            {
              "text": "1. Sort laundry by color and fabric type. 2. Start the washing machine with appropriate settings and detergent. 3. Transfer clothes to dryer or hang them to air dry. 4. Fold and organize laundry by category. 5. Put away folded laundry in their designated spots."
            }
          ]
        }
      )
    end
  end
end
