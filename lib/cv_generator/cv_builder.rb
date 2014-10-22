 module CvGenerator
  module CvBuilder

    class CvLinkedIn < Prawn::Document

      def initialize(client)
        super()
        @basic_profile = client.get_basic_profile
        @full_profile = client.get_full_profile
        @positions = client.get_positions
        @educations = client.get_educations

        styles
        header
        summary
        experience
        languages
        educations
        skills_and_expertise
      end

      def styles
        stroke_color "989898"
      end

      def header
        if @basic_profile.picture_url
          image open(@basic_profile.picture_url), width: 70, height: 70, :position => :right, :at => [475, cursor]
        end
        text @basic_profile.formatted_name, :size => 18, style: :bold, :valign => :top
        text @basic_profile.headline, :size => 13, :valign => :top
        text "<link href='mailto:#{@basic_profile.email.downcase}'>#{@basic_profile.email.downcase}</link>", :size => 11, :valign => :top, :style => :italic, :color => "6B8FB2", :inline_format => true
        text "<link href='#{@basic_profile.public_profile_url}'>Ir al perfil</link>", :size => 10, :valign => :top, :style => :bold, :color => "6B8FB2", :inline_format => true
        move_down 20
        stroke_horizontal_rule
        move_down 10
      end

      def summary
        if @basic_profile.summary
          text 'Summary', size: 18, color: '585859'
          move_down 10
          text @basic_profile.summary, :inline_format => true
          move_down 10
          stroke_horizontal_rule
          move_down 20
        end
      end

      def experience
        text 'Experience', size: 18, color: '585859'
        move_down 10
        @positions.each do |position|
          text "#{position.title} at #{position.company}", :style => :bold
          if position.start_date and position.end_date
          text "From #{position.start_date.to_s} to #{position.end_date.to_s}"  , :style => :italic, size: 11, color: 'A5A5A5'
          end
          text position.summary
          move_down 15
        end
        move_down 10
        stroke_horizontal_rule
        move_down 20
      end

      def languages
        if @full_profile.languages.count > 0
          text 'Languages', size: 18, color: '585859'
          move_down 10
          @full_profile.languages.each do |element|
            text element, style: :italic
          end
          move_down 10
          stroke_horizontal_rule
          move_down 15
        end
      end

      def educations
        text 'Education', size: 18, color: '585859'
        move_down 10
        @educations.each do |education|
          text education.school_name, style: :bold
          text education.degree, style: :italic
          text education.field_of_study
          if education.start_date and education.end_date
            text "From #{education[:start_date].to_s} to #{education[:end_date].to_s}", :style => :italic, size: 11, color: 'A5A5A5'
          end
          move_down 15
        end
        move_down 10
        stroke_horizontal_rule
        move_down 15
      end

      def skills_and_expertise
        if @full_profile.interests
          text 'Skills and Expetise', size: 18, color: '585859'
          move_down 10
          text @full_profile.interests
        end
      end

    end
  end
 end
