require 'spec_helper'

describe CvGenerator::ProfileFactory do

  describe 'Basic Profile' do

    subject { CvGenerator::ProfileFactory.basic_profile(first_name: 'Gerardo', last_name: 'Ortega', email: 'foo@bar.com', location: 'Narnia')  }

    it { should be_kind_of  CvGenerator::ProfileFactory::BasicProfile }

    it {  should respond_to(:first_name, :last_name, :email, :formatted_name,
                        :headline, :location,  :industry, :summary, :specialties,
                        :picture_url, :public_profile_url) }

    it 'should have uninitized values as nils' do
      subject.formatted_name.should be_nil
      subject.headline.should be_nil
      subject.summary.should be_nil
    end

  end

  describe 'Full Profile' do

    subject { CvGenerator::ProfileFactory.full_profile(associations: %w{rubyni kakao},
                                                       languages: %w{english spanish}   )  }

    it { should be_kind_of  CvGenerator::ProfileFactory::FullProfile }

    it {  should respond_to(:associations, :honors, :interests, :languages) }

    it 'should have uninitized values as nils' do
      subject.interests.should be_nil
      subject.honors.should be_nil
    end

    it 'should store values in arrays' do
      subject.associations.should be_kind_of(Array)
    end

  end


end