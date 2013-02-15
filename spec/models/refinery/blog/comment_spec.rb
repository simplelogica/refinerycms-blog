require 'spec_helper'

module Refinery
  module Blog
    describe Comment, :vcr do
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
          FactoryGirl.create(:blog_comment)
        end

        subject { comment }

        its (:state) { should eq "spam" }
      end

      context "forcing as spam" do

        let(:comment) do
          FactoryGirl.create(:blog_comment)
        end

        before { subject.spam! }

        subject { comment }

        its (:state) { should eq "spam" }
      end

      context "forcing a spam comment as ham" do

        let(:comment) do
          FactoryGirl.create(:blog_comment)
        end

        before { subject.ham! }

        subject { comment }

        its (:state) { should be_nil }
      end
    end
  end
end
