module CvGenerator
  module Profile

      def linkedin_client
        client ||= get_client
      end

      # Basic Profile
      def get_basic_profile
        profile = linkedin_client.profile(:fields => ['first-name', 'last-name', 'maiden-name', 'formatted-name' ,:headline, :location, :industry, :summary, :specialties, 'picture-url', 'public-profile-url', 'email-address'])
        BasicProfile.new( profile['first_name'], profile['last_name'], profile['email_address'],
                          profile['maiden_name'], profile['formatted_name'],
                          profile['headline'], profile['location']['name'],
                          profile['industry'], profile['summary'],
                          profile['specialties'], profile['picture_url'],
                          profile['public_profile_url'])
      end

      #Full profile
      def get_extended_profile
        profile = linkedin_client.profile(:fields => [:associations, :honors, :interests, :languages])
        ExtendedProfile.new(  profile['associations'], profile['honors'],
                              profile['interests'], get_languages(profile['languages']) )
      end

      #Positions
      def get_positions
        positions = linkedin_client.profile(:fields => [:positions]).positions['values']

        positions_list = []
        positions.each do |p|
            positions_list << Position.new(p['title'],  p['summary'],
                                           get_date(p['start_date']),
                                           get_date(p['end_date']),
                                           p['is_current'],
                                           p['company']['name'] )
        end
        positions_list
      end

      # Educations
      def get_educations
        educations = linkedin_client.profile(:fields => [:educations]).educations['values']
        educations_list = []
        educations.each do |e|
          educations_list << Education.new(e['school_name'], e['field_of_study'],
                                           get_date(e['start_date']),
                                           get_date(e['end_date']),
                                           e['degree'], e['activities'],
                                           e['notes'])
        end
        educations_list
      end


    protected

    def get_languages(languages_api_data)
      languages = []
      languages_api_data['all'].each do |element|
        languages << element['language']['name']
      end
      languages
    end

    def get_date(date_info)
      if date_info.nil?
        nil
      else
         Date.parse("1/#{date_info['month'] ? date_info['month'] : 1}/#{date_info['year']}")
      end
    end

  end
end