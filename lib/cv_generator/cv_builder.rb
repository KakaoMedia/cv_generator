 module CvGenerator
  module CvBuilder

    class CvLinkedIn < Prawn::Document

      def initialize(client)
        super()
        @basic_profile = client.get_basic_profile
        @extended_profile = client.get_full_profile
        @positions = client.get_positions
        @educations = client.get_educations

        header
        summary
        experience
        languages
        educations
        skills_and_expertise
      end

      def header
        image open(@basic_profile.picture_url), width: 75, height: 75
        move_down 10
        text @basic_profile.formatted_name, :align => :left, :size => 18
        text @basic_profile.headline, :align => :left, :size => 14
        move_down 20
        stroke_horizontal_rule
        move_down 10
      end

      def summary
        if @basic_profile.summary
          text 'Summary', size: 18
          move_down 10
          text @basic_profile.summary
          move_down 10
          stroke_horizontal_rule
          move_down 20
        end
      end

      def experience
        text 'Experience', size: 18
        move_down 10
        @positions.each do |position|
          text "#{position.title} at #{position.company}", :style => :bold
          if position.start_date and position.end_date
          text "From #{position.start_date.to_s} to #{position.end_date.to_s}"  , :style => :italic
          end
          text position.summary
        end
        move_down 10
        stroke_horizontal_rule
        move_down 20
      end

      def languages
        text 'Languages', size: 18
        move_down 10
        @extended_profile.languages.each do |element|
          text element, style: :italic
        end
        move_down 10
        stroke_horizontal_rule
        move_down 15
      end

      def educations
        text 'Education', size: 18
        move_down 10
        @educations.each do |education|
          text education.school_name, style: :bold
          text education.degree, style: :italic
          text education.field_of_study
          if education.start_date and education.end_date
            text "From #{education[:start_date].to_s} to #{education[:end_date].to_s}"
          end
          move_down 15
        end
        move_down 10
        stroke_horizontal_rule
        move_down 15
      end

      def skills_and_expertise
        if @extended_profile.interests
          text 'Skills and Expetise', size: 18
          move_down 10
          text @extended_profile.interests
        end
      end

    end
  end
 end
