# frozen_string_literal: true

module Admin
  class ApplicationController < Administrate::ApplicationController
    include Localization

    before_action :authenticate_user!
    before_action :authenticate_admin

    def authenticate_admin
      redirect_to root_path, alert: t('auth_admin_alert') unless current_user.admin?
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
