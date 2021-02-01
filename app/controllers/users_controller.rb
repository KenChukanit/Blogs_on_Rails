class UsersController < ApplicationController

    before_action :authenticate_user!, only: [:edit, :update]
    

    def new
        @user=User.new
    end

    def create
        @user=User.new user_params
        if @user.save
            session[:user_id]=@user.id
            redirect_to root_path, notice: "Logged in!"
        else
            render :new
        end
    end
    
    def edit
        @user = User.find params[:id]
    end

    def update
        @user = User.find params[:id]
        
        if @user.update user_params
        redirect_to root_path , notice: "You have updated your profile"
        else  
            render :edit
        end
    end

    def change_password
    
    end

    def do_change_password
        current_password = params[:user][:current_password] 
        new_password = params[:user][:new_password]
        new_password_confirmation = params[:user][:new_password_confirmation]
        
        if new_password != new_password_confirmation
            flash[:alert] = "Passwords must match." 
            redirect_to user_change_password_path(@user)
            return
        end

        if current_password.present? == false ||
            new_password.present? == false ||
            new_password_confirmation.present? == false
            flash[:alert] = "Please fill all the required password." 
            redirect_to user_change_password_path(@user)
            return
        end
        # if system can authenthicate new password then the new password is same as old password.
        if  @user.authenticate(new_password)
            flash[:alert] = "Cannot use the same password." 
            redirect_to user_change_password_path(@user)
            return
        end
        # if system can authenthicate current password then the old password is same as old password. so we can process.
        if  @user.authenticate(current_password)
            @user.update(password: new_password,
                        password_confirmation: new_password_confirmation)
            @user.save
            respond_to do |format|
                format.html { redirect_to root_path, notice: 'Your password has been changed.' }
            end
        else
            flash[:alert] = "Invalid password." 
            redirect_to user_change_password_path(@user)
        end
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end



end
