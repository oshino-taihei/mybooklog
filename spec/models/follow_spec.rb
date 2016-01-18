require 'rails_helper'

describe Follow, type: :model do
  it 'from_user_id, to_user_idがあれば正常であること' do
    follow = Follow.new(from_user_id: 1, to_user_id: 2)
    expect(follow).to be_valid
  end

  it 'from_user_idがなければエラーであること' do
    follow = Follow.new(from_user_id: nil, to_user_id: 2)
    expect(follow).not_to be_valid
  end

  it 'to_user_idがなければエラーであること' do
    follow = Follow.new(from_user_id: 1, to_user_id: nil)
    expect(follow).not_to be_valid
  end

  it 'to_user_idはfrom_user_idごとに一意でなければエラーであること' do
    follow1 = Follow.create(from_user_id: 1, to_user_id: 2)
    follow2 = Follow.new(from_user_id: 1, to_user_id: 2)
    expect(follow2).not_to be_valid
  end
end
