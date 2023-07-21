class RoomsController < ApplicationController
    before_action :set_room, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource except: :create
  
    def index
      @rooms = Room.all
    end
  
    def show
    end
  
  
    private
  
    def set_room
      @room = Room.find(params[:id])
    end
  end
  