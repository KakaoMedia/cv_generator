module CvGenerator

  class Client

    include CvGenerator::Profile
    include CvGenerator::CvBuilder
    include CvGenerator::Exceptions

    def initialize(options = {})

      if has_app_params?(options)
        @consumer_key = options[:consumer_key]
        @consumer_secret = options[:consumer_secret]
        @atoken = options[:atoken]
        @asecret = options[:asecret]
      else
        raise MissingParametersException
      end

    end

    def get_client
       client = LinkedIn::Client.new(@consumer_key, @consumer_secret)
       client.authorize_from_access(@atoken, @asecret)
       client
     end

    def generate_pdf
      pdf_document.render
    end

    def pdf_document
      CvLinkedIn.new(self)
    end

    private

    def has_app_params?(options)
      options.has_key?(:consumer_key) and
          options.has_key?(:consumer_secret) and
            options.has_key?(:atoken) and
              options.has_key?(:asecret)
    end


  end


end