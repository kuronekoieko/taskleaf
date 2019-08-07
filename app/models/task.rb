# encoding: utf-8
class Task < ApplicationRecord
  #before_validation :set_nameless_name
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  validate :validate_name_not_including_comma

  #外部から呼ばれることを想定していないのでprivateにしておく
  private

  #自前の検証メソッド
  def validate_name_not_including_comma
    #検証エラーを確認したら、errorsに格納する
    errors.add(:name, "にカンマを含めることは出来ません") if name&.include?(",")
  end

  #コールバックの練習用、nilまたは空文字が入ってきたときに代入する
  # def set_nameless_name
  # self.name = "名前無し" if name.blank?
  # end
end
