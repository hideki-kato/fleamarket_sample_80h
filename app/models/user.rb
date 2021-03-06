class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  validates :nick_name, presence: true
  validates :family_name, presence: true,             format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'は全角で入力して下さい。'}
  validates :first_name, presence: true,              format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'は全角で入力して下さい。'}
  validates :family_name_kana, presence: true,        format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :first_name_kana, presence: true,         format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :birthday, presence: true
  require 'date'

  private def date_valid?(str)
    !! Date.parse(str) rescue false
  end

  has_one :delivery_destination
  has_one :credit_card
  has_one :phone_number
  has_many :items
  has_many :seller_orders, class_name: 'Order', foreign_key: 'seller_id'
  has_many :buyer_orders, class_name: 'Order', foreign_key: 'buyer_id'
  has_many :sns_credentials
  accepts_nested_attributes_for :credit_card
  accepts_nested_attributes_for :phone_number
  accepts_nested_attributes_for :delivery_destination

  mount_uploader :image, ImageUploader
end
