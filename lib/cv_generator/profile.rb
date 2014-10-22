module CvGenerator
  module Profile
    include CvGenerator::ProfileFactory

      def linkedin_client
        client ||= get_client
      end

      # Basic Profile
      def get_basic_profile
        basic_profile = linkedin_client.profile(:fields => ['first-name', 'last-name', 'maiden-name', 'formatted-name' ,:headline, :location, :industry, :summary, :specialties, 'picture-url', 'public-profile-url', 'email-address'])
        ProfileFactory.basic_profile(first_name: basic_profile['first_name'], last_name: basic_profile['last_name'],
                                     email: basic_profile['email_address'], formatted_name: basic_profile['formatted_name'],
                                     headline: basic_profile['headline'], location: basic_profile['location']['name'],
                                     industry: basic_profile['industry'], summary: basic_profile['summary'], specialties: basic_profile['specialties'],
                                     picture_url: basic_profile['picture_url'], public_profile_url: basic_profile['public_profile_url'] )
      end

      #Full profile
      def get_full_profile
        full_profile = linkedin_client.profile(:fields => [:associations, :honors, :interests, :languages])
        ProfileFactory.full_profile(associations: full_profile[:associations], honors: full_profile[:honors],
                                    interests: full_profile[:interests], languages: get_languages(full_profile['languages']))
      end

      #Positions
      def get_positions
        positions = linkedin_client.profile(:fields => [:positions]).positions['values']

        positions_list = []
        positions.each do |p|
            positions_list << ProfileFactory.position(title: p['title'], summary: p['summary'],
                                                       start_date: get_date(p['start_date']), end_date: get_date(p['end_date']),
                                                       is_current: p['is_current'], company: p['company']['name'] )
        end
        positions_list
      end

      # Educations
      def get_educations
        educations = linkedin_client.profile(:fields => [:educations]).educations['values']
        educations_list = []
        educations.each do |e|
          educations_list << ProfileFactory.education(school_name: e['school_name'], field_of_study: e['field_of_study'],
                                                      start_date: get_date(e['start_date']), end_date: get_date(e['end_date']),
                                                      degree: e['degree'], activities: e['activities'], notes: e['notes'] )
        end
        educations_list
      end


    protected

    def get_languages(languages_api_data)
      languages = []
      unless languages_api_data.nil?
        languages_api_data['all'].each do |element|
            languages << element['language']['name']
        end
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