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

  #   task3_spec
  describe "promotions" do
    it "returns the barcodes of the promotions item" do
    prom = CountGoods.new
    prom_item = prom.promotion_item
    expect(["ITEM000000", "ITEM000001", "ITEM000005"]).to eq(prom_item)
    end
  end   #   "promotions"   end

  #   task4_spec
  describe "discount" do
    it "get the total price you need to pay for every good with its discount" do
      discount = CountGoods.new
      discount.count_item
      discount.item_detail
      discount.promotion_item
      discount_goods = discount.youhui_goods
      expect([{"barcode"=>"ITEM000001", "name"=>"雪碧", "unit"=>"瓶", "price"=>3.0, "count"=>5, "new_count"=>4, "total_price"=>12.0, "discount"=>3.0},
         {"barcode"=>"ITEM000003", "name"=>"荔枝", "unit"=>"斤", "price"=>15.0, "count"=>2, "new_count"=>2, "total_price"=>30.0, "discount"=>0.0},
          {"barcode"=>"ITEM000005", "name"=>"方便面", "unit"=>"袋", "price"=>4.5, "count"=>3, "new_count"=>2, "total_price"=>9.0, "discount"=>4.5}])
          .to eq(discount_goods)
    end
  end   #   "discount"   end

  #   task5_spec
  describe "total" do
    it "get the total cost and total discount for all the goods" do
      total = CountGoods.new
      total.count_item
      total.item_detail
      total.promotion_item
      total.youhui_goods
      total_info = total.total_goods
      expect({"total_cost"=>51.0, "total_discount"=>7.5}).to eq(total_info)
    end
  end   #   "total"   end


  #   task6_spec
  #describe "print" do
  #  it "print the shopping list" do
  #    list = CountGoods.new
  #    list.count_item
  #    list.item_detail
  #    list.promotion_item
  #    list.youhui_goods
  #    list.total_goods
  #    goods_list = list.shopping_list
  #    expect("").to eq(goods_list)
  #  end
  #end   #   "print"   end



end  #  CountGoods   end
