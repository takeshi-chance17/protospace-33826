class PrototypesController < ApplicationController
    before_action :set_prototype, only:[:show, :edit]
    before_action :authenticate_user!, only:[:create,:new,:edit,:update,:delete]
    before_action :move_to_index, only:[:edit, :update, :delete]

    def index
        # @User = User.all
        # @prototypes = Prototype.all
        @prototypes = Prototype.includes(:user)
    end

    def new
        @prototype = Prototype.new
    end

    def create
        binding.pry
        prototype = Prototype.create(prototype_params)

        if prototype.save
            redirect_to root_path
        else
            render :new
        end
    end

    def show
        @comment = Comment.new
        @comments = @prototype.comments.includes(:user)
    end

    def edit
    end

    def update
        prototype = Prototype.find(params[:id])
        if prototype.update(prototype_params)
            redirect_to prototype_path(params[:id])
        else
            set_prototype
            render :edit
        end
    end

    def destroy
        prototype = Prototype.find(params[:id])
        prototype.destroy
        redirect_to root_path
    end

    private
    def prototype_params
        params.require(:prototype).permit(:image, :title, :catch_copy, :concept).merge(user_id: current_user.id)
    end

    def set_prototype
        @prototype = Prototype.find(params[:id])
    end

    def move_to_index
        unless user_signed_in? || @prototype.user_id == current_user.id
            redirect_to action: :index
        end
    end
end
