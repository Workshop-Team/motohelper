# frozen_string_literal: true

require 'httparty'
module GoogleApi
  FIND_OBJECT_NEARBY_RADIUS = 1000
  CAR_REPAIR_TYPE = 'car_repair'
  CAR_DEALER_TYPE = 'car_dealer'
  PLACES_API_URL = 'https://maps.googleapis.com/maps/api/place'
  GEOCODE_API_URL = 'https://maps.googleapis.com/maps/api/geocode'

  def get_workshops_with_details(latitude, longitude)
    objects_to_array(latitude, longitude, CAR_REPAIR_TYPE) + objects_to_array(latitude, longitude, CAR_DEALER_TYPE)
  end

  def find_objects_nearby(latitude, longitude, type)
    response = HTTParty.get("#{PLACES_API_URL}/nearbysearch/json?#{object_nearby_params(latitude, longitude, type)}")
    JSON.parse(response.body)
  end

  def get_place_details(place_id)
    response = HTTParty.get("#{PLACES_API_URL}/details/json?#{place_details_params(place_id)}")
    JSON.parse(response.body)
  end

  def get_address(latitude, longitude, language)
    response = HTTParty.get("#{GEOCODE_API_URL}/json?#{get_address_params(latitude, longitude, language)}")
    JSON.parse(response.body)
  end

  private

  def object_nearby_params(latitude, longitude, type)
    "location=#{latitude},#{longitude}&radius=#{FIND_OBJECT_NEARBY_RADIUS}&type=#{type}&key=#{secrets}"
  end

  def place_details_params(place_id)
    "placeid=#{place_id}&key=#{secrets}"
  end

  def get_address_params(latitude, longitude, language)
    "latlng=#{latitude},#{longitude}&language=#{language}&key=#{secrets}"
  end

  def objects_to_array(latitude, longitude, type)
    places = []
    find_objects_nearby(latitude, longitude, type)['results'].each do |object|
      places << get_place_details(object['place_id'])['result']
    end
    places.compact
  end

  def secrets
    ENV['GOOGLE_API_KEY']
  end

  module_function :get_workshops_with_details, :find_objects_nearby, :get_place_details, :get_address,
                  :object_nearby_params, :place_details_params, :objects_to_array, :get_address_params, :secrets
end
