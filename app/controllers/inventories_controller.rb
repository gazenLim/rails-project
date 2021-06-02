class InventoriesController < ApplicationController
before_action :show_action,  only: [:show , :edit, :update,   :destroy]
before_action :redirect_if_not_owner, only: [:edit, :update, :destroy]

def index
    if params[:user_id]
        show_user
        if @user.nil?
            redirect_to inventories_path
        else
        @inventories = @user.inventories.order(delivery: :asc)
        end
    else
    @inventories = Inventory.alpha_order
    end  
    
    end

    def show
    end

def new
    if @user = current_user
    @inventory = @user.inventories.build
    else
        @inventory = Inventory.new
end
end

def create
    if @user = current_user
    @inventory = @user.inventories.build(inventory_params)
    else
        @inventory = Inventory.new(inventory_params)
    end
    if @inventory.save
               if @user
                flash[:message] = "Your Inventory Saved"
    redirect_to user_inventories_path(@user)
                else
                redirect_to inventory(@inventory)
                end
    else
        render :new
    end
end

    def edit
    end


    def update
         if @user = current_user
            show_user
            @inventory.update(inventory_params)
            flash[:message] = "Inventory Edited"
            redirect_to user_inventory_path(@user, @inventory)
        end
    end
        
    def destroy
        if @user = current_user
            show_user
        @inventory.destroy
        flash[:message] = "Yours inventory is Deleted"
        redirect_to user_inventories_path(@user)
        end
    end

    def deliveryweek
        @inventories = Inventory.all
    end

private

def inventory_params
    params.require(:inventory).permit(:amount, :delivery, :product_id, :user_id)
end

def show_action
    @inventory = Inventory.find(params[:id])
end

def show_user
    @user = User.find_by_id(params[:user_id])

end



def redirect_if_not_owner
    if @inventory.user != current_user
        flash[:message] = "You are not Authorized"
        redirect_to inventories_path
    end
end





end
