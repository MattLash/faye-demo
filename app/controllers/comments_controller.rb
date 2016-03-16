class CommentsController < ApplicationController
    
   def new
       @comment = Comment.new
       @comments = Comment.order('created_at DESC')
   end
   
   def create
      respond_to do |format|
         if current_user
            @comment = current_user.comments.build(comment_params)
            if @comment.save
               flash[:success] = "You posted a comment!"
            else 
               flash[:error] = "You failed"
            end
            format.html {redirect_to root_url}
            format.js
         else 
            format.html {redirect_to root_url}
            format.js
         end
      end
   end
   
   def index
      # @comments = Comment.order('created_at DESC')
      # below we've re-written the comments variable to pull a query where id is 
      # greater than something, that something is the following argument. The following
      # argument is looking at params, then looking after "id" and converting this to an integer
      @comments = Comment.where('id > ?', params[:after_id].to_i).order("created_at DESC")
   end
   
   private 
      
      def comment_params
         params.require(:comment).permit(:body)
      end
    
end