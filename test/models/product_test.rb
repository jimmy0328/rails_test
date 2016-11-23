require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "production price must large 1" do
    product = new_product('zzz.jpg')

    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 1"],
      product.errors[:price]
    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 1"],
      product.errors[:price]
    product.price = 1
    assert product.valid?
  end


  test "title is uniqueness" do
    product = Product.new(title: products(:apple).title, description: "yyy", price: 1, image_url: 'pineapple.jpg')
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

  def new_product(image_url)
    Product.new(title: "My Book Title", description: "yyy", price: 1, image_url: image_url)
  end


end
