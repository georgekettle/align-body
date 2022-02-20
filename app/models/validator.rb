class Validator
  def self.make(name="DataValidator", data, validations)
    validator_class = Class.new do
      include ActiveModel::Validations

      attr_accessor(*validations.keys)

      validations.each do |attribute, attribute_validations|
        validates attribute, attribute_validations
      end

      def initialize(data)
        data.each do |key, value|
          self.instance_variable_set("@#{key.to_sym}", value)
        end
      end
    end

    Object.const_set(name, validator_class).new(data)
  end
end