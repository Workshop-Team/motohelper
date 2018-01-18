# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!, only: :dashboard

  def dashboard
    @data = {}

    @data[:cars] = current_user.cars.decorate
    @data[:closest_service] = nil
    @data[:maintenances] = current_user.maintenances.most_recent(5)
    @data[:mileages] = current_user.mileages.most_recent(5).decorate
    @data[:reminders] = current_user.reminders.most_recent(5)
    @data[:closest_service] = find_nearby['car_repair']
  end

  def find_nearby
    FindNearby.new.find_places(current_user.latitude, current_user.longitude)
  end
end
