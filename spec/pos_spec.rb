require '../lib/pos'
#require './goods-example.json'

describe CountGoods do
  #  task1_spec
  describe "#count" do
    it "returns the barcode and count of the goods you buy" do
      pos_goods = CountGoods.new
      goods = JSON.parse(File.read('../spec/fixture/goods-example.json'))
      goods_buy = pos_goods.count_item(goods)
      expect({"ITEM000001"=>5, "ITEM000003"=>2, "ITEM000005"=>3}).to eq(goods_buy)
    end
  end   #   "#count"   end

  #  task2_spec
  describe "#detail" do
    it "returns the detail information of the goods you buy" do
      pos_goods = CountGoods.new
      goods = JSON.parse(File.read('../spec/fixture/goods-example.json'))
      all_goods = JSON.parse(File.read('../spec/fixture/all-items.json'))
      goods_buy = pos_goods.count_item(goods)
      goods_detail = pos_goods.item_detail(all_goods,goods_buy)
      expect([{"barcode"=>"ITEM000001", "name"=>"雪碧", "unit"=>"瓶", "price"=>3.0, "count"=>5},
         {"barcode"=>"ITEM000003", "name"=>"荔枝", "unit"=>"斤", "price"=>15.0, "count"=>2},
         {"barcode"=>"ITEM000005", "name"=>"方便面", "unit"=>"袋", "price"=>4.5, "count"=>3}]).to eq(goods_detail)
    end
  end   #   "#detail"   end

  #   task3_spec
  describe "promotions" do
    it "returns the barcodes of the promotions item" do
    pos_goods = CountGoods.new
    promotions = JSON.parse(File.read('../spec/fixture/promotions.json'))
    prom_barcode = pos_goods.promotion_item(promotions)
    expect(["ITEM000000", "ITEM000001", "ITEM000005"]).to eq(prom_barcode)
    end
  end   #   "promotions"   end

  #   task4_spec
  describe "discount" do
    it "get the total price you need to pay for every good with its discount" do
      pos_goods = CountGoods.new
      goods = JSON.parse(File.read('../spec/fixture/goods-example.json'))
      all_goods = JSON.parse(File.read('../spec/fixture/all-items.json'))
      goods_buy = pos_goods.count_item(goods)
      goods_detail = pos_goods.item_detail(all_goods,goods_buy)

      promotions = JSON.parse(File.read('../spec/fixture/promotions.json'))
      prom_barcode = pos_goods.promotion_item(promotions)

      discount_goods = pos_goods.youhui_goods(goods_detail,prom_barcode)
      expect([{"barcode"=>"ITEM000001", "name"=>"雪碧", "unit"=>"瓶", "price"=>3.0, "count"=>5, "new_count"=>4, "total_price"=>12.0, "discount"=>3.0},
         {"barcode"=>"ITEM000003", "name"=>"荔枝", "unit"=>"斤", "price"=>15.0, "count"=>2, "new_count"=>2, "total_price"=>30.0, "discount"=>0.0},
          {"barcode"=>"ITEM000005", "name"=>"方便面", "unit"=>"袋", "price"=>4.5, "count"=>3, "new_count"=>2, "total_price"=>9.0, "discount"=>4.5}])
          .to eq(discount_goods)
    end
  end   #   "discount"   end

  #   task5_spec
  describe "total" do
    it "get the total cost and total discount for all the goods" do
      pos_goods = CountGoods.new

      goods = JSON.parse(File.read('../spec/fixture/goods-example.json'))
      all_goods = JSON.parse(File.read('../spec/fixture/all-items.json'))
      goods_buy = pos_goods.count_item(goods)
      goods_detail = pos_goods.item_detail(all_goods,goods_buy)

      promotions = JSON.parse(File.read('../spec/fixture/promotions.json'))
      prom_barcode = pos_goods.promotion_item(promotions)

      discount_goods = pos_goods.youhui_goods(goods_detail,prom_barcode)

      total_info = pos_goods.total_goods(discount_goods)
      expect({"total_cost"=>51.0, "total_discount"=>7.5}).to eq(total_info)
    end
  end   #   "total"   end


  #   task6_spec
  #describe "print" do
  #  it "print the shopping list" do
  #    pos_goods = CountGoods.new
  #    goods = JSON.parse(File.read('../spec/fixture/goods-example.json'))
  #    all_goods = JSON.parse(File.read('../spec/fixture/all-items.json'))
  #    goods_buy = pos_goods.count_item(goods)
  #    goods_detail = pos_goods.item_detail(all_goods,goods_buy)

  #    promotions = JSON.parse(File.read('../spec/fixture/promotions.json'))
  #    prom_barcode = pos_goods.promotion_item(promotions)

  #    discount_goods = pos_goods.youhui_goods(goods_detail,prom_barcode)

  #    total_info = pos_goods.total_goods(discount_goods)
  #    goods_list = pos_goods.shopping_list(discount_goods,total_info)
  #    expect("").to eq(goods_list)
  #  end
  #end   #   "print"   end



end  #  CountGoods   end
