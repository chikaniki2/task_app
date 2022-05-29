class Task < ApplicationRecord
  validates :title, presence: true
  validates :date_start, presence: true
  validates :date_end, presence: true

  validate :date_before_start# 開始日が終了日より後ならエラー
  validate :date_before_finish # 終了日が今日より前ならエラー

  #関数_開始日が終了日より後ならエラー
  def date_before_start
    if date_start.blank? || date_end.blank?
      return #どちらか空欄ならスルー
    elsif date_end < date_start
      errors.add(:date_end, "は開始日以降の日付を選択してください")
    end
  end

  # 関数_終了日が今日より前ならエラー
  def date_before_finish
    if date_end.blank?
      return
    elsif date_end <= Date.today
      errors.add(:date_end, "は今日以降の日付を選択してください")
    end
  end

end
