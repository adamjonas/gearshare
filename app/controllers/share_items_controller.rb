class ShareItemsController < ApplicationController

  def new 
  	@shared_item = SharedItem.new
  end


  def create
  	

  	current_user.request_to_borrow_item_by_id(params[:id])
    
    @share = current_user.share.build(:item_id => params[:item_id])

    respond_to do |format|
      if @share.save
        format.html { redirect_to @share, notice: 'You shared an item.' }
        format.json { render json: @share, status: :created, location: @share }
        flash[:notice] = "You shared your gear."
      else
        format.html { render action: "new" }
        format.json { render json: @share.errors, status: :unprocessable_entity }
        flash[:error] = "Unable to share this gear."
      end
    end
  end
	


end
