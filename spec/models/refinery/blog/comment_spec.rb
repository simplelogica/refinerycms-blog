require 'spec_helper'

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

      context "detecting spam", :vcr do

        let(:comment) do
          FactoryGirl.create(:blog_comment)
        end

        subject { comment }

        its (:state) { should eq "spam" }
      end
    end
  end
end
