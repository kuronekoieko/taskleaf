# encoding: utf-8
class Task < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  validates :validates_name_not_including_comma

  #外部から呼ばれることを想定していないのでprivateにしておく
  private

  #自前の検証メソッド
  def validates_name_not_including_comma
    #検証エラーを確認したら、errorsに格納する
    errors.add(:name, "にカンマを含めることは出来ません") if name&.include?(",")
  end
end
