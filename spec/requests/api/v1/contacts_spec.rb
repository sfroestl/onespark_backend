require 'spec_helper'

describe "Api::V1::Contacts" do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:contact) { FactoryGirl.create(:user) }
  let!(:old_contact) { FactoryGirl.create(:user) }
  let!(:old_contact2) { FactoryGirl.create(:user) }
  let(:contacts_url) { "api/v1/contacts"}

  describe "(POST) create a contact request" do
    before { post "#{contacts_url}", { contact: { contact_id: contact.id } }, basic_auth(user.username) }

    it "response status is 201" do
      response.status.should eql(201)
    end

    it "response contains new contacts request" do
      response.body.should include("#{contact.id}")
      response.body.should include("#{user.id}")
    end

    it "requested contact status is pending" do
      response.body.should include("status")
      response.body.should include("pending")
    end
  end


  describe "(GET) all user contacts" do
    before do
      Friendship.request(user, old_contact)
      Friendship.accept(user, old_contact)
      Friendship.request(user, old_contact2)
      Friendship.accept(user, old_contact2)
      get "#{contacts_url}", nil, basic_auth(user.username)
    end

    it "response status is 200" do
      response.status.should eql(200)
    end

    it "response contains all contacts" do
      response_json = JSON.parse(response.body)
      response_json['contacts'].count.should eql(2)
      response.body.should include ("#{old_contact.id}")
      response.body.should include ("#{old_contact2.id}")
    end

    it "with status accepted" do
        response.body.should include ("accepted")
        response.body.should_not include ("pending")
        response.body.should_not include ("requested")
    end

    describe "with new contact request" do
      before do
        @new_contact_req = Friendship.request(contact, user)
        get "#{contacts_url}", nil, basic_auth(user.username)
      end

      it "response contains accepted and new requested" do
        response.body.should include ("#{old_contact.id}")
        response.body.should include ("#{old_contact2.id}")
        response.body.should include ("#{contact.id}")
      end
      it "response contains new contact request with status requested" do
        response_json = JSON.parse(response.body)
        response_json['contacts'].count.should eql(3)
        response.body.should include ("requested")
      end
    end
  end
end
