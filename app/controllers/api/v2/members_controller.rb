module Api
  module V2
    class MembersController < ApiController

      before_action :set_member, except: [:index]
      before_action :require_login, only: [:update, :destroy, :check_admin, :require_admin]
      before_action :require_admin, only: [:update, :destroy]
      # GET /members
      def index
        @members = Member.all
        render json: @members
      end

      # GET /members/1
      def show
        render json: @member
      end

      # PATCH/PUT /members/1
      def update
        if @member.update(member_params)
          render json: @member
        else
          render json: @member.errors, status: :unprocessable_entity
        end
      end

      # DELETE /members/1
      def destroy
        if @member
          @member.destroy
          render json: {message: "Successfully deleted!"}, status: :ok
        else
          render json: {message: "Something wrong"}, status: 404
        end
      end

      # GET /members/1/check_admin
      def check_admin
        if @member.admin
          render json: {admin: true}, status: :ok
        else
          render json: {admin: false}, status: :ok
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_member
          @member = Member.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def member_params
          params.permit(:username, :email, :password)
        end

        def require_login
          authenticate_member!
        end

        def require_admin
         if current_member.admin != true
           render json: {message: "You don't have permission to do that!"}, status: :forbidden
         end
        end
    end
  end
end
