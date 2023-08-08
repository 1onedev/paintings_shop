class TransactionDecorator < Draper::Decorator
  delegate_all

  def card_logo
    case object.sender_card_type
    when 'mc' then 'mc.png'
    when 'visa' then 'visa.png'
    else 
      'default-card.png'
    end  
  end

  def sender_name
    [object.sender_first_name, object.sender_last_name].join(' ')
  end

  def sender_phone
    Phoner::Phone.parse("+#{object.sender_phone}").format(:us) rescue nil
  end  
end
