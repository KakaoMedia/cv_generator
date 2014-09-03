module CvGenerator

  class Client

    include CvGenerator::Profile
    include CvGenerator::CvBuilder

    def initialize(options = {})
      @consumer_key = options[:consumer_key]
      @consumer_secret = options[:consumer_secret]
      @atoken = options[:atoken]
      @asecret = options[:asecret]
    end

   def get_client
     client = LinkedIn::Client.new(@consumer_key, @consumer_secret)
     client.authorize_from_access(@atoken, @asecret)
     client
   end

  def generate_pdf
    CvLinkedIn.new(basic_profile: get_basic_profile,
                   full_profile: get_full_profile,
                   positions: get_positions,
                   educations: get_educations).render
  end

  end


end