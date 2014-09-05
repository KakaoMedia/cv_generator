 module CvGenerator
  module CvBuilder

    class CvLinkedIn < Prawn::Document

      def initialize(client)
        super()
        @basic_profile = client.get_basic_profile
        @full_profile = client.get_full_profile
        @positions = client.get_positions
        @educations = client.get_educations

        header
        basic_profile
        experience
        languages
        educations
        skills_and_expertise
      end

      def header
        image open(@basic_profile['picture_url']), width: 75, height: 75
        move_down 10
        text @basic_profile['formatted_name'], :align => :left, :size => 18
        text @basic_profile['headline'], :align => :left, :size => 14
        move_down 20
        stroke_horizontal_rule
        move_down 10
      end

      def basic_profile
        text 'Summary', size: 18
        move_down 10
        text @basic_profile['summary']
        move_down 10
        stroke_horizontal_rule
        move_down 20
      end

      def experience
        text 'Experience', size: 18
        move_down 10
        @positions.each do |position|
          text "#{position[:title]} at #{position[:company]}", :style => :bold
          text "From #{position[:start_date].to_s} to #{position[:end_date].to_s}"  , :style => :italic
          text position[:summary]
        end
        move_down 10
        stroke_horizontal_rule
        move_down 20
      end

      def languages
        text 'Languages', size: 18
        move_down 10
        @full_profile['languages']['values'].each do |element|
          text element['language']['name'], style: :italic
        end
        move_down 10
        stroke_horizontal_rule
        move_down 15
      end

      def educations
        text 'Education', size: 18
        move_down 10
        @educations.each do |education|
          text education[:school_name], style: :bold
          text education[:degree], style: :italic
          text education[:field_of_study]
          text "From #{education[:start_date].to_s} to #{education[:end_date].to_s}"
        end
        move_down 10
        stroke_horizontal_rule
        move_down 15
      end

      def skills_and_expertise
        text 'Skills and Expetise', size: 18
        move_down 10
        text @full_profile['interests']
      end

    end
  end
 end
