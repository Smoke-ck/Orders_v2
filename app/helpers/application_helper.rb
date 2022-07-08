# frozen_string_literal: true

module ApplicationHelper
  def form_error(model)
    render "shared/errors", object: model
  end

  def prepend_flash
    turbo_stream.replace "flash", partial: "shared/flash"
  end
end
