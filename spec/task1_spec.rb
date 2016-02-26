require '../lib/pos'
#require './goods-example.json'

describe CountGoods do
  #  task1_spec
  describe "#count" do
    it "returns the barcode and count of the goods you buy" do
      count_goods = CountGoods.new
      goodsCounting = count_goods.count_item
      expect({"ITEM000001"=>5, "ITEM000003"=>2, "ITEM000005"=>3}).to eq(goodsCounting)
    end
  end   #   "#count"   end
  #  task2_spec
  describe "#detail" do
    it "returns the detail information of the goods you buy" do
      detail = CountGoods.new
      detail.count_item
      detail_goods = detail.item_detail
      expect([{"barcode"=>"ITEM000001", "name"=>"雪碧", "unit"=>"瓶", "price"=>3.0, "count"=>5},
         {"barcode"=>"ITEM000003", "name"=>"荔枝", "unit"=>"斤", "price"=>15.0, "count"=>2},
         {"barcode"=>"ITEM000005", "name"=>"方便面", "unit"=>"袋", "price"=>4.5, "count"=>3}]).to eq(detail_goods)
    end
  end   #   "#detail"   end



end  #  CountGoods   end
