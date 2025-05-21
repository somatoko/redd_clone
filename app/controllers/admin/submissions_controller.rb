
class Admin::SubmissionsController < ApplicationController
  def index
    @submissions = Submission.all.sort
  end
end