class EvidencesController < ApplicationController
  before_action :logged_in_user,          only: [:index, :edit, :update, :new, :create, :destroy]
  before_action :correct_user,            only: [:index]
  before_action :company_user,            only: [:edit, :update, :new, :create, :destroy]
  before_action :right_user,              only: [:index, :edit, :destroy]
  
  def index
    if !params[:answer_id]
      flash[:danger] = "Please choose an answer!"
      redirect_to answers_url and return
    end
    if !Answer.exists?(params[:answer_id])
      flash[:warning] = "Please choose a valid answer."
      redirect_to answers_url and return 
    end
    @answer = Answer.find(params[:answer_id])
    @evidences = @answer.evidences
  end
  
  def new
    @evidence = Evidence.new
    @relationship = @evidence.relationships.build
  end
  
  def edit
    @evidence = Evidence.find(params[:id])
    @relationship = @evidence.relationships.build
  end
  
  
  def create
    @answer = Answer.find(params[:evidence][:answer_id])
    object = ActiveStorage::Blob.find_by(filename: params[:evidence][:name])
    if object
      attach = ActiveStorage::Attachment.find_by(blob_id: object.id)
      @evidence = Evidence.find(attach.record_id)
    else
      @evidence = Evidence.new(evidence_params)
      @evidence.save
    end
    @answer.create_evidence(@evidence)
    relationship = @answer.relationships.where('evidence_id = ?',@evidence.id) 
    relationship.update(comment: params[:relationship][:comment])
    flash[:success] = "Successfully upload evidence"
    redirect_to evidences_url(answer_id: params[:evidence][:answer_id])
  end
  
  def update
    @evidence = Evidence.find(params[:id])
    if params[:relationship][:comment]
      @answer = Answer.find(params[:evidence][:answer_id])
      relationship = @answer.relationships.where('evidence_id = ?',@evidence.id)  
      relationship.update(comment: params[:relationship][:comment])
    end
    
    if @evidence.update_attributes(evidence_params)
      flash[:success] = "Successfully updated."
      redirect_to evidences_path(answer_id: params[:evidence][:answer_id])
    else
      render 'edit'
    end
  end
  
  def destroy
    Evidence.find(params[:id]).destroy
    flash[:success] = "Evidence deleted"
    redirect_to evidences_url(answer_id: params[:answer_id])
  end
  
   private
   
    def company_user
      unless company_representative?
        store_location
        flash[:warning] = "You do not have permission."
        redirect_to(root_url)
      end
    end
    
    def correct_user
      unless validator? or company_representative?
        store_location
        flash[:warning] = "You do not  permission."
        redirect_to(root_url)
      end
    end
    
    def right_user
      if company_representative?
        answer = Answer.find(params[:answer_id])
        cpn = current_user.company
        if !cpn.has_answer?(answer) && !validator?
          flash[:warning] = "You do not have permission to edit other's evidence!"
          redirect_to answers_url and return 
        end
      end
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def evidence_params
      params.require(:evidence).permit(:name, :file)
    end
end
