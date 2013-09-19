class SessionsController < ApplicationController

  def log_in
    if current_user
      redirect_to home_path
    end
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to home_path, :notice => 'Logged in'
    else
      if params[:login] == 'admin' && there_is_no_admin
        create_admin
        flash.now.alert = 'Default admin was created. Login: admin. Password: admin.'
      else
        flash.now.alert = 'Invalid login or password'
      end
      render 'log_in'
    end
  end

  def there_is_no_admin
    !User.where(:login => 'admin').any?
  end

  def create_admin
    User.new({:login => 'admin', :password => 'admin'}).save
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => 'Logged out'
  end

  private :create_admin, :there_is_no_admin

end
