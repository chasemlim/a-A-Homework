require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", name: "Gerald") }
  subject(:icecream) { Dessert.new("Ice Cream", 50, chef)}

  describe "#initialize" do
    it "sets a type" do
      expect(icecream.type).to eq("Ice Cream")
    end
    it "sets a quantity" do
      expect(icecream.quantity).to eq(50)
    end

    it "starts ingredients as an empty array" do
      expect(icecream.ingredients).to eq([])
    end

    context "when quantity isn't an Integer" do
    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("Bagel", "five", chef) }.to raise_error(ArgumentError)
    end
  end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      icecream.add_ingredient("milk")
      expect(icecream.ingredients).to include("milk")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      ingredients = ["milk", "cream", "chocolate", "ice"]

      ingredients.each do |i|
        icecream.ingredients << i
      end

      expect(icecream.mix!).not_to eq(ingredients.shuffle)
      expect(icecream.ingredients.sort).to eq(ingredients.sort)
    end

  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      icecream.eat(10)

      expect(icecream.quantity).to eq(40)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect{icecream.eat(100)}.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Gerald the Great Baker")
      expect(icecream.serve).to eq("Gerald the Great Baker has made 50 Ice Creams!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      allow(chef).to receive(:bake).with(icecream)
      icecream.make_more
    end
  end
end
