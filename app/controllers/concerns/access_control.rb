# frozen_string_literal: true

module AccessControl
  extend ActiveSupport::Concern

  included do
    before_action :check_access, only: %i[edit update destroy]
  end

  private

  def check_access
    redirect_to("/", alert: "You don't have access to this page.") unless current_user.can_access_admin_views?
  end

  # Example of dynamic redirect path method

  # def check_access(redirect_path_method = nil)
  #   unless current_user.can_access_admin_views?
  #     redirect_path = redirect_path_method ? send(redirect_path_method) : "/"
  #     redirect_to(redirect_path, alert: "You don't have access to this page.")
  #   end
  # end
end
