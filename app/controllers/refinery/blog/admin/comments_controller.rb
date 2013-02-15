module Refinery
  module Blog
    module Admin
      class CommentsController < ::Refinery::AdminController

        crudify :'refinery/blog/comment',
                :title_attribute => :name,
                :order => 'published_at DESC'

        def index
          @comments = Refinery::Blog::Comment.unmoderated.page(params[:page])

          render :action => 'index'
        end

        def approved
          unless params[:id].present?
            @comments = Refinery::Blog::Comment.approved.page(params[:page])

            render :action => 'index'
          else
            @comment = Refinery::Blog::Comment.find(params[:id])
            @comment.approve!
            flash[:notice] = t('approved', :scope => 'refinery.blog.admin.comments', :author => @comment.name)

            redirect_to refinery.url_for(:action => params[:return_to] || 'index', :id => nil)
          end
        end

        def rejected
          unless params[:id].present?
            @comments = Refinery::Blog::Comment.rejected.page(params[:page])

            render :action => 'index'
          else
            @comment = Refinery::Blog::Comment.find(params[:id])
            @comment.reject!
            flash[:notice] = t('rejected', :scope => 'refinery.blog.admin.comments', :author => @comment.name)

            redirect_to refinery.url_for(:action => params[:return_to] || 'index', :id => nil)
          end
        end

        def spam
          @comments = Refinery::Blog::Comment.spam.page(params[:page])
          render :index
        end

        def mark_as_spam
          @comment = Refinery::Blog::Comment.find(params[:id])
          @comment.spam!
          flash[:notice] = t('marked_as_spam', :scope => 'refinery.blog.admin.comments', :author => @comment.name)

          redirect_to refinery.blog_admin_comments_path
        end

        def mark_as_ham
          @comment = Refinery::Blog::Comment.find(params[:id])
          @comment.ham!
          flash[:notice] = t('marked_as_ham', :scope => 'refinery.blog.admin.comments', :author => @comment.name)

          redirect_to refinery.blog_admin_comments_path
        end
      end
    end
  end
end
