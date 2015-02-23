namespace :adoptapet_sync do

  require 'csv'
  require 'net/ftp'
  require 'open-uri'
  require 'fileutils'

  path = "/tmp/adoptapet/"
  STATES = ['PA','MD','VA']

  desc "Export Records to CSV for adoptapet"
  task export_upload: :environment do

    FileUtils::Verbose.rm_r(path) if Dir.exists?(path)
    FileUtils::Verbose.mkdir(path)

    STATES.each do |state|

      filename = "pets_#{state}.csv"

      puts Time.now.strftime("%m/%d/%Y %H:%M")+ " Adoptapet #{state} Export Start"

      dogs = Dog.joins(:foster).where(
        { status: ["adoptable",
          "adoption pending",
          "on hold",
          "return pending",
          "coming soon"],
          users: {state: state}
         })

      CSV.open(path + filename, "wt", force_quotes: "true", col_sep: ",") do |csv|

        dogs.each do |d|
          photo_urls = Array.new
          d.photos.public.sort!{|a,b| b.updated_at <=> a.updated_at }
          d.photos.public[0..3].each do |p|
            photo_urls << p.photo.url(:large)
          end

          csv << [d.id.to_s,
                  "Dog",
                  d.primary_breed ? d.primary_breed.name : "",
                  d.secondary_breed ? d.secondary_breed.name : "",
                  "N",                             #PureBreed
                  d.name,
                  d.age,
                  d.to_petfinder_gender,
                  d.to_petfinder_size,
                  d.description.gsub(/\r\n?/, "&#10;"),
                  "Available",                      #status
                  d.no_kids ? "N" : "Y",            #GoodWKids
                  d.no_cats ? "N" : "Y",            #GoodWCats
                  d.no_dogs ? "N" : "Y",            #GoodWDogs
                  d.is_altered ? "Y" : "N",         #SpayedNeutered
                  d.is_special_needs ? "Y" : "N",    #SpecialNeeds
                  photo_urls[0],
                  photo_urls[1],
                  photo_urls[2],
                  photo_urls[3]
          ]
        end
      end
      puts Time.now.strftime("%m/%d/%Y %H:%M")+ " Adoptapet #{state} Export Complete"

      #Add Step to copy import.cfg to /tmp/adoptapet/
      #Add FTP upload step for each state here


    end



  end
end