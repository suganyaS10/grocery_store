# frozen_string_literal: true

# Responsible for Bill Generations and Report generations
class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def generate_bill
    @detailed_bill_hash = Purchase.generate_bill(current_user)
  end

  def pay_bill
    @purchase = Purchase.find(params[:id])

    if @purchase.update_attributes!(status: 'paid')
      status = 'success'
      message = 'Your bill paid successfully! You will receive your order soon'
    else
      status = 'Failure'
      message = 'Something went wrong !'
    end

    @response = { status: status, message: message }
  end

  def purchase_report
  end

  def generate_purchase_report
    @purchases_hash = Purchase.generate_purchase_report(params[:from],
                                                        params[:to])
  end
end
