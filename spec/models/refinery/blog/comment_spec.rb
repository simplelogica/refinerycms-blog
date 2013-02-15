require 'spec_helper'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr/'
  c.hook_into :webmock # or :fakeweb
  c.allow_http_connections_when_no_cassette = true
end

module Refinery
  module Blog
    describe Comment do
      context "wiring up" do
        let(:comment) { FactoryGirl.create(:blog_comment) }

        it "saves" do
          comment.should_not be_nil
        end

        it "has a blog post" do
          comment.post.should_not be_nil
        end
      end

      context "detecting spam" do
        let(:comment) do
          VCR.use_cassette('akismet', :record => :new_episodes, :match_requests_on => [:path]) do
            FactoryGirl.create(:blog_comment)
          end
        end

        subject { comment }

        its (:state) { should eq "spam" }
      end
    end
  end
end
