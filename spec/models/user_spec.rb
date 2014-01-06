require 'spec_helper'

describe User do

  it 'should fall back to email when a name is not present' do
    user_without_name = build(:user, name: "")
    user_with_name = build(:user, name: "My Name")
    expect(user_with_name.name).to eq "My Name"
    expect(user_without_name.name).to eq user_without_name.email
  end
end
