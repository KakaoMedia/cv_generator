require 'linkedin'
require 'prawn'
require 'date'
require 'open-uri'

module CvGenerator


  autoload :Client,  'cv_generator/client'
  autoload :Profile, 'cv_generator/profile'
  autoload :CvBuilder, 'cv_generator/cv_builder'
  autoload :ProfileFactory, 'cv_generator/profile_factory'
  autoload :Exceptions, 'cv_generator/exceptions'
end
