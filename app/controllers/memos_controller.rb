class MemosController < ApplicationController
  before_action :set_memo, only: [:show, :edit, :update, :destroy, :complete, :duplicate]

  # GET /memos
  # GET /memos.json
  def index
    @memos = Memo.all.order("created_at DESC")
  end

  # GET /memos/1
  # GET /memos/1.json
  def show
  end

  # GET /memos/new
  def new
    @memo = Memo.new
  end

  # GET /memos/1/edit
  def edit
  end

  # POST /memos
  # POST /memos.json
  def create
    @memo = Memo.new(memo_params)
    @memo.user = current_user
    respond_to do |format|
      if @memo.save
        format.html { redirect_to @memo, notice: 'Memo was added.' }
        format.json { render :show, status: :created, location: @memo }
      else
        format.html { render :new }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memos/1
  # PATCH/PUT /memos/1.json
  def update
    respond_to do |format|
      if @memo.update(memo_params)
        format.html { redirect_to @memo, notice: 'Memo was updated.' }
        format.json { render :show, status: :ok, location: @memo }
      else
        format.html { render :edit }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memos/1
  # DELETE /memos/1.json
  def destroy
    @memo.destroy
    respond_to do |format|
      format.html { redirect_to memos_url, notice: 'Memo was deleted.' }
      format.json { head :no_content }
    end
  end

  #COMPLETE
  #Method should eventaully move to a completed memos database or just have a vale changed
  def complete
    @memo.destroy
    respond_to do |format|
      format.html { redirect_to memos_url, notice: 'Memo was Completed and Removed.' }
      format.json { head :no_content }
    end
  end

  #DUPLICATE
  #Method goes to form with info already filled out so memo can be edited if needed
  def duplicate
    template = Memo.find(params[:id])
    @memo = template.dup
    render action: 'new'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memo
      @memo = Memo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def memo_params
      params.require(:memo).permit(:title, :content)
    end
end
