module RefactoringATest
  RSpec.describe DB do
    let(:object) { :an_object }

    after do
      DB.delete(object)
    end

    it "saves an object" do
      DB.save(object)

      expect(DB.instance.all).to eq([object])
    end

    it "deletes an object" do
      DB.save(object)
      DB.delete(object)

      expect(DB.instance.all).to eq([])
    end
  end
end
