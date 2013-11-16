class AccountsController < ApplicationController
  # require the current user to be authenticated to access this controller
  before_filter :authenticate_brother!

  def index
    @brothers = Brother.findAllByFraternityID current_brother.fraternity_id
  
  end

  def detail
  end

  def verify
    @brothers = Brother.findAllPendingByFraternityID current_brother.fraternity_id
  end

  def invite
    # verify that we're an admin
    if ! current_brother.is_admin
      redirect_to accounts_path
      return
    end


  end
end
