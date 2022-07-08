# frozen_string_literal: true

class ApplicationService
  attr_reader :params, :options

  class << self
    def call(*params)
      new(*params).call
    end

    def call!(*params)
      new(*params).call!
    end

    def parameters(*names)
      @parameter_names = names

      names.each_with_index do |name, index|
        define_method(name) { params[index] }
      end
    end

    def options(*names)
      define_method(:options) { @options.slice(*names) }
    end

    def parameter_names
      @parameter_names ||= []
    end
  end

  def initialize(*params)
    @params = params
    @options = params.size > described_parameters.size && params.last.respond_to?(:to_hash) ? @params.pop : {}
  end

  def call
    raise NotImplementedError
  end

  def call!
    raise NotImplementedError
  end

  private

  def described_parameters
    self.class.parameter_names
  end
end
