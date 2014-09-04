module CvGenerator
  module Profile

      def linkedin_client
        client ||= get_client
      end

      # Basic Profile
      def get_basic_profile
        profile = linkedin_client.profile(:fields => ['first-name', 'last-name', 'maiden-name', 'formatted-name' ,:headline, :location, :industry, :summary, :specialties, 'picture-url', 'public-profile-url', 'email-address'])
        basic_profile = profile.to_hash
        basic_profile[:location] = basic_profile['location']['name']
        basic_profile.to_hash
      end

      #Full profile
      def get_full_profile
        full_profile = linkedin_client.profile(:fields => [:associations, :honors, :interests, :languages])
        full_profile.to_hash
      end

      #Positions
      def get_positions
        positions = linkedin_client.profile(:fields => [:positions]).positions['values']

        positions_list = []
        positions.each do |p|

          if p['isCurrent'] == 'true'
            positions_list << {
                title: p['title'],
                summary: p['summary'],
                start_date: Date.parse("1/#{p['startDate']['month'] ? p['startDate']['month'] : 1}/#{p['startDate']['year']}"),
                end_date: Date.parse("1/#{p['endDate']['month'] ? p['endDate']['month'] : 1}/#{p['endDate']['year']}"),
                is_current: p['isCurrent'],
                company: p['company']['name']
                }
          else
            positions_list << {
                title: p['title'],
                summary: p['summary'],
                start_date: Date.parse("1/#{p['startDate']['month'] ? p['startDate']['month'] : 1}/#{p['startDate']['year']}"),
                is_current: p['isCurrent'],
                company: p['company']['name']
                }
          end
        end
        positions_list
      end

      # Educations
      def get_educations
        educations = linkedin_client.profile(:fields => [:educations]).educations['values']
        educations_list = []
        educations.each do |e|
          educations_list << {
              school_name: e['schoolName'],
              field_of_study: e['fieldOfStudy'],
              start_date: Date.parse("1/#{e['startDate']['month'] ? e['startDate']['month'] : 1}/#{e['startDate']['year']}"),
              end_date: Date.parse("1/#{e['endDate']['month'] ? e['endDate']['month'] : 1}/#{e['endDate']['year']}"),
              degree: e['degree'],
              activities: e['activities'],
              notes: e['notes'] }
        end
        educations_list
      end

     def get_recomendations
       #TODO: Include recommendations
       #linkedin_client.profile.(:fields => [:recommendations])
     end

  end
end