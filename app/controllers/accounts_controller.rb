class AccountsController < ApplicationController
  # require the current user to be authenticated to access this controller
  before_filter :authenticate_brother!
  
  def index
    @brothers = Brother.findAllByFraternityID current_brother.fraternity_id
    @pending_bros = Brother.findAllPendingByFraternityID current_brother.fraternity_id   
  end

  def detail 
  end

  def verify
    if ! current_brother.is_admin
      redirect_to accounts_path
      return
    end

    id = params[:id]
    Brother.verify id
  end

  def deny
    if ! current_brother.is_admin
      redirect_to accounts_path
      return
    end
    
    id = params[:id]
    Brother.destroy id 
  end

  def invite
    # verify that we're an admin
    if ! current_brother.is_admin
      redirect_to accounts_path
      return
    end

  end

  def processInvite
    @firstname = params[:brother][:firstname]
    @lastname = params[:brother][:lastname] 
    @email = params[:brother][:email]

    brother = Brother.new( 
                  :firstname => @firstname, 
                  :lastname  => @lastname,
                  :email => @email,
                  :password => params[:brother][:password],
                  :password_confirmation => params[:brother][:password],
                  :fraternity_id => current_brother.fraternity_id,
                  :is_verified => true
                    )
    brother.save()
  end

  private

  def post_params
    params.require(:brother).permit(:firstname, :lastname, :email, :password)
  end
end
