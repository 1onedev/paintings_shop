class Setting < ApplicationRecord
  jsonb_accessor :settings_data, market_name:         [:string, default: ''],
                                 market_name_en:      [:string, default: ''],
                                 about_market:        [:text, default: ''],
                                 about_market_en:     [:text, default: ''],
                                 phones:              [:text, default: ''],
                                 emails:              [:text, default: ''],
                                 adresses:            [:text, default: ''],
                                 adresses_en:         [:text, default: ''],
                                 time_work:           [:text, default: ''],
                                 cart_location:       [:text, default: ''],
                                 social_links:        [:text, default: ''] 

  has_attached_file :logo

  do_not_validate_attachment_file_type :logo

  def market_name
    if I18n.locale == :en && market_name_en.present?
      market_name_en
    else
      super
    end
  end

  def about_market
    if I18n.locale == :en && about_market_en.present?
      about_market_en
    else
      super
    end
  end

  def adresses
    if I18n.locale == :en && adresses_en.present?
      adresses_en
    else
      super
    end
  end
end