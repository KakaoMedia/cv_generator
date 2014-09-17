require 'spec_helper'

describe CvGenerator::Client do

  let(:client) { CvGenerator::Client.new(consumer_key: ENV['LINKEDIN_APIKEY'], consumer_secret: ENV['LINKEDIN_APISECRET'], atoken: ENV['LINKEDIN_ATOKEN'], asecret: ENV['LINKEDIN_ASECRET'] )  }


  it { client.should be_kind_of(CvGenerator::Client)  }

  describe '#generate_pdf' do
    # it { client.generate_pdf }
  end

  describe '#pdf_document' do

  end

  describe '#get_basic_profile' do

    subject { client.get_basic_profile }

    it { should be_kind_of(CvGenerator::ProfileFactory::BasicProfile)}

  end




end