class Order < ActiveRecord::Base
  attr_accessible :account_member_id, :status, :destination_id, :total_all_price, :cart_id, :total_all_price_dollar, :code_order,
                  :card_number, :card_verification, :card_expires_on, :first_name, :last_name

  attr_accessor :card_number, :card_verification, :card_expires_on, :first_name, :last_name
  columns_hash["card_expires_on"] = ActiveRecord::ConnectionAdapters::Column.new("card_expires_on", nil, "date")

  belongs_to :account_member
  belongs_to :destination
  belongs_to :cart

  has_many :line_items
  has_many :transactions, :class_name => "OrderTransaction"

  before_save :change_to_dollar, :random_code_order
  after_save :change_stock
  
  validate :validate_card, on: :create

  def change_stock
    cart.sisa_stok
  end

  def random_code_order
    self.code_order ||= rand(36**10).to_s(36)
  end
  
  def purchase
    response = GATEWAY.purchase(total_amount, credit_card, purchase_options)
    transactions.create!(:action => "purchase", :amount => total_amount, :response => response)
    cart.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end

  def total_all(price)
  	self.total_all_price = price
  end

  def change_to_dollar
    @bank = Money::Bank::GoogleCurrency.new
    rate = @bank.get_rate(:IDR, :USD)

    @total_dollar = self.total_all_price * rate.to_f
    self.total_all_price_dollar = @total_dollar
  end

  def total_amount
    @total_dollar = self.total_all_price / 100
  end

  def cancel_order!
    self.update_attributes!(:status => -1)
  end

  private
  
  def purchase_options
    {
      :ip => '127.0.0.1',
      :billing_address => {
        :name     => "Ryan Bates",
        :address1 => "123 Main St.",
        :city     => "New York",
        :state    => "NY",
        :country  => "US",
        :zip      => "10001"
      }
    }
  end
  
  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add_to_base message
      end
    end
  end

   def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :brand              => 'Visa',
      :number             => "4244856001245482",
      :verification_value => "123",
      :month              => '6',
      :year               => '2018',
      :first_name         => "Muhammad",
      :last_name          => "Hidayatulloh"
    )
  end
end
