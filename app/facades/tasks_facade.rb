class TasksFacade
  def self.filter_check(params)
    if params[:category].present?
      TaskSerializer.new(Task.where(user_id: params[:user_id], category: params[:category]))
    elsif params[:frequency].present?
      TaskSerializer.new(Task.where(user_id: params[:user_id], frequency: params[:frequency]))
    elsif params[:mandatory].present?
      TaskSerializer.new(Task.where(user_id: params[:user_id], mandatory: params[:mandatory]))
    else
    end
  end


end