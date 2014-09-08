class UserStepsController < ApplicationController
  include Wicked::Wizard
  steps :organization , :organization_address
  
  def show
    @user = current_user
    render_wizard
  end
  
  def update
    @user = current_user
    
    puts "*********** user #{@user.owner_organization.inspect}"
    puts "*********** permit_params #{permit_params.inspect}"
    
    @user.attributes = permit_params
    @user.save!

    render_wizard @user
  end
  
private

  def redirect_to_finish_wizard(options = {})
    redirect_to root_url, notice: "Thank you for signing up."
  end
  
  def permit_params    
    params.require(:user).permit(:name, 
    owner_organization_attributes: [:name, :employees, :organization_type, :demographic_market,
    address_attributes: [:address1,:address2,:city,:state,:country,:phone, :zipcode]  ])
  end  

end
