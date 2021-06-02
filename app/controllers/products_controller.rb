class ProductsController < ApplicationController
before_action :actions_show, only: [:show]
rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
    def index
        @products = Product.all
        
    end

    def show
                     
    end



    private
    def actions_show
        @product = Product.find(params[:id])
    end

    def handle_record_not_found
        # Send it to the view that is specific for Post not found
        render :not_found
      end

end
