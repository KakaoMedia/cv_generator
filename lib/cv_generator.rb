require 'linkedin'
require 'prawn'
require 'date'
require 'open-uri'

module CvGenerator

  BasicProfile = Struct.new(:first_name, :last_name, :email, :maiden_name, :formatted_name, :headline, :location,  :industry, :summary, :specialties, :picture_url, :public_profile_url)

  ExtendedProfile = Struct.new(:associations, :honors, :interests, :languages)

  Position = Struct.new(:title, :summary, :start_date, :end_date, :is_current,:company)

  Education = Struct.new(:school_name, :field_of_study, :start_date, :end_date, :degree, :activities, :notes)


  autoload :Client,  'cv_generator/client'
  autoload :Profile, 'cv_generator/profile'
  autoload :CvBuilder, 'cv_generator/cv_builder'
  autoload :Exceptions, 'cv_generator/exceptions'
end
