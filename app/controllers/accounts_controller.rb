class AccountsController < ApplicationController
  # require the current user to be authenticated to access this controller
  before_filter :authenticate_brother!
  before_filter :is_verified!
  
  def index
    @brothers = current_brother.fraternity.verified_brothers
    @pending_bros = current_brother.fraternity.pending_brothers 
  end

  def detail
    @brother = Brother.find params[:id]
    @rushees = Rushee.findAllByPrimaryContactID @brother.id
  end

  def verify
    if ! current_brother.is_admin
      redirect_to accounts_path
      return
    end

    id = params[:id]
    Brother.verify id

    redirect_to accounts_path
  end

  def deny
    if ! current_brother.is_admin
      redirect_to accounts_path
      return
    end
    
    id = params[:id]
    if id.to_i != current_brother.id
      Brother.destroy id 
    end
    redirect_to accounts_path
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
  
  def is_verified!
    if !current_brother.is_verified    
      sign_out current_brother
      redirect_to :root
      return
    end
  end
end
