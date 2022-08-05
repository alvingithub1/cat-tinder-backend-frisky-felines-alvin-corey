require 'rails_helper'

RSpec.describe Cat, type: :model do
  it "Should validate name" do
    cat = Cat.create(age: 2, enjoys: 'laying in the sun', image: 'https://images.unsplash.com/photo-1492370284958-c20b15c692d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1049&q=80')

    expect(cat.errors[:name]).to_not be_empty
  end

  it "Should validate age" do
    cat = Cat.create(name: 'shredder', enjoys: 'laying in the sun', image: 'https://images.unsplash.com/photo-1492370284958-c20b15c692d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1049&q=80')

    expect(cat.errors[:age]).to_not be_empty
  end

  it "Should validate enjoys" do
    cat = Cat.create(name: 'shredder', age: 2, image: 'https://images.unsplash.com/photo-1492370284958-c20b15c692d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1049&q=80')

    expect(cat.errors[:enjoys]).to_not be_empty
  end

  it "Should validate image" do
    cat = Cat.create(name: 'shredder', age: 2, enjoys: 'laying in the sun')

    expect(cat.errors[:image]).to_not be_empty
  end

  it "enjoys should be at least 10 characters" do
    cat = Cat.create(name: 'shredder', age: 2, enjoys: 'laying', image: 'https://images.unsplash.com/photo-1492370284958-c20b15c692d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1049&q=80')

    expect(cat.errors[:enjoys]).to_not be_empty
  end
end
