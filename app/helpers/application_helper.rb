# frozen_string_literal: true

module ApplicationHelper
  def form_error(model)
    render "shared/errors", object: model
  end
end
