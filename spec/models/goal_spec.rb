describe Goal do
  subject(:goal){create(:goal)}
  describe "#daily_streak" do
    before do
      create(:activity, goal: goal, created_at: 6.days.ago, user: goal.user)
      create(:activity, goal: goal, created_at: 4.days.ago, user: goal.user)
      create(:activity, goal: goal, created_at: 3.days.ago, user: goal.user)
      create(:activity, goal: goal, created_at: 2.days.ago, user: goal.user)
    end
    it "returns number of days with activities" do
      expect(goal.daily_streak).to eq(3)
    end
  end
end