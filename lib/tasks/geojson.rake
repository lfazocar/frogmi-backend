require 'net/http'
require 'json'

namespace :geojson do
  desc "Retrieve earthquake data in GeoJSON format from URL provided in .env file and update the database with it"
  task month: :environment do
    puts "Downloading data from past 30 days"
    uri = URI('https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson')
    geojson = JSON.parse(Net::HTTP.get(uri))

    db_features = Feature.pluck(:external_id)
    retrieved, added, duplicates = 0, 0, 0
    puts 'Updating database...'
    geojson['features'].each do |feat|
      unless db_features.include?(feat['id'])
        new_feature = Feature.new(
          external_id: feat['id'],
          title: feat['properties']['title'],
          url: feat['properties']['url'],
          place: feat['properties']['place'],
          mag_type: feat['properties']['magType'],
          magnitude: feat['properties']['mag'],
          time: feat['properties']['time'],
          tsunami: feat['properties']['tsunami'] == 1,
          longitude: feat['geometry']['coordinates'][0],
          latitude: feat['geometry']['coordinates'][1])
          added += 1 if new_feature.save()
      else
        duplicates += 1
      end
      retrieved += 1
    end
    puts "Retrieved #{retrieved} features"
    puts "Added #{added} new features to the database"
    puts "#{duplicates} features not added because they are duplicates"
    puts "#{retrieved - added - duplicates} features not added because they didn't pass validations"
  end
end
