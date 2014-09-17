module CvGenerator

  module ProfileFactory

    BasicProfile = Struct.new(:first_name, :last_name, :email, :formatted_name, :headline, :location,  :industry, :summary, :specialties, :picture_url, :public_profile_url)

    FullProfile = Struct.new(:associations, :honors, :interests, :languages)

    Position = Struct.new(:title, :summary, :start_date, :end_date, :is_current,:company)

    Education = Struct.new(:school_name, :field_of_study, :start_date, :end_date, :degree, :activities, :notes)

    def self.basic_profile(args)
      BasicProfile.new(args[:first_name], args[:last_name],
                       args[:email], args[:formatted_name], args[:headline],
                       args[:location], args[:industry],
                       args[:summary], args[:specialties],
                       args[:picture_url], args[:public_profile_url])
    end

    def self.full_profile(args)
      FullProfile.new(args[:associations], args[:honors], args[:interests], args[:languages])
    end

    def self.position(args)
      Position.new(args[:title], args[:summary], args[:start_date],
                   args[:end_date], args[:is_current], args[:company])
    end

    def self.education(args)
      Education.new(args[:school_name], args[:field_of_study], args[:start_date],
                    args[:end_date], args[:degree], args[:activities], args[:notes])
    end


  end

end