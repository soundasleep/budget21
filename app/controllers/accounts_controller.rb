class AccountsController < ApplicationController
  def index
    @accounts = Account.all
  end

  def show
    @account = Account.find(params[:id])
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(update_params)
    if @account.save
      flash[:notice] = "Created new account."

      redirect_to @account
    else
      flash[:errors] = account.errors.full_messages
      render "new"
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    @account.assign_attributes(update_params)
    if @account.save
      flash[:notice] = "Updated account."
      redirect_to @account
    else
      flash[:errors] = @account.errors.full_messages
      render "edit"
    end
  end

  def upload
    @account = Account.find(params[:id])
    @account.update(upload_params)
    if @account.save
      file_type = nil
      first_row = nil
      transactions_found = 0
      transactions_created = 0
      transactions_updated = 0

      CSV.foreach(@account.last_csv.current_path, "r") do |row|
        first_row ||= row

        if row[0] == "Account number" && row[1] == "Date" && row[2] == "Memo/Description" && row[3] == "Source Code (payment type)" &&
            row.length == 16
          file_type = :kiwibank
        elsif row[0].match?(/[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}/) && row[1].nil? && row[2].nil? && row[3].nil? && row.length == 4
          file_type = :kiwibank_cc

        else
          case file_type
          when :kiwibank
            # 0              1    2                3                          4      5       6       7      8       9       10      11                     12              13             14     15
            # Account number,Date,Memo/Description,Source Code (payment type),TP ref,TP part,TP code,OP ref,OP part,OP code,OP name,OP Bank Account Number,Amount (credit),Amount (debit),Amount,Balance
            txn = @account.transactions.where({
              description: row[2],
              source_code: row[3],
              tp_ref: row[4],
              op_ref: row[7],
              op_name: row[10],
              op_bank_account: row[11],
              amount: row[14],
            }).where("date >= ? AND date <= ?", row[1].to_date.beginning_of_day, row[1].to_date.end_of_day).first_or_create
            if txn.new_record?
              transactions_created += 1
            else
              transactions_updated += 1
            end
            txn.update!({
              date: row[1],
              tp_part: row[5],
              tp_code: row[6],
              op_part: row[8],
              op_code: row[9],
            })
            transactions_found += 1
          when :kiwibank_cc
            # 0    1           2      3
            # Date,Description,Card #,Amount
            txn = @account.transactions.where({
              description: row[1],
              tp_ref: row[2],
              amount: row[3]
            }).where("date >= ? AND date <= ?", row[0].to_date.beginning_of_day, row[0].to_date.end_of_day).first_or_create
            if txn.new_record?
              transactions_created += 1
            else
              transactions_updated += 1
            end
            txn.update!({
              date: row[0],
            })
            transactions_found += 1
          else
            flash[:errors] = "Unknown file format to process: #{first_row}"
            render "show"
            return
          end
        end
      end

      flash[:notice] = "Uploaded #{@account.last_csv.identifier} and found #{transactions_found} transactions - created #{transactions_created}, updated #{transactions_updated}"
      redirect_to @account
    else
      flash[:errors] = @account.errors.full_messages
      render "show"
    end
  end

  private

  def update_params
    params.require(:account).permit(:name)
  end

  def upload_params
    params.require(:account).permit(:last_csv)
  end
end
