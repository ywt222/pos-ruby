require 'rubygems'
require 'json'
require 'pp'



class CountGoods

# task1:count the items in goods-example.json
  def count_item(goods)

    goods_buy = Hash.new
    goods.each do |item|

      barcode = item.split('-')[0]
      num = item.split('-')[1]
      value = num.nil? ? 1: num.to_i

      if goods_buy[barcode].nil?
        goods_buy[barcode] = value
      else
        goods_buy[barcode] += value
      end
    end
    goods_buy
  end   #   def count_item   end


# task2:load all items from all-items.json
  def item_detail(all_goods,goods_buy)
    goods_buy_array = Array.new
    goods_buy_array = goods_buy.to_a
    goods_detail = Array.new
    all_goods_ini = Array.new

    all_goods.each do |item|
      all_goods_ini << item.merge("count"=>0)
    end

# 46-52行也可为54-60行
    all_goods_ini.each do |i|
      goods_buy_array.each do |j|
        if i["barcode"] == j[0]
          i["count"] += j[1]
        end
      end
    end

    #@all_goods_ini.each do |item|
    #  for j in 0..goods_buy_array.size-1
    #    if item["barcode"] == goods_buy_array[j][0]
    #      item["count"] += goods_buy_array[j][1]
    #    end
    #  end
    #end

    all_goods_ini.each do |item|
      if item["count"] != 0
        goods_detail << item
      end
    end

    goods_detail

  end # def item_detail   end


  # task3: load the promotions barcodes
  def promotion_item(promotions)
    prom_barcode = promotions[0]["barcodes"]
  end   # def promotion_item   end


  # task4: get the promotion of the goods we buy
  def youhui_goods(goods_detail,prom_barcode)
    goods_detail_new = Array.new
    goods_detail.each do |item|
      goods_detail_new << item.merge("new_count"=>"#{item["count"]}".to_i)
    end
    prom_barcode.each do |i|
      goods_detail_new.each do |j|
        if i == j["barcode"]
          j["new_count"] = j["count"]-j["count"]/3
        end
      end
    end
    discount_goods = Array.new
    goods_detail_new.each do |item|
      total_price = item["price"]*item["new_count"]
      discount = item["price"]*(item["count"]-item["new_count"])
      discount_goods << item.merge("total_price"=>"#{total_price}".to_f,"discount"=>"#{discount}".to_f)
    end
    discount_goods

  end   # def youhui_goods   end


# task5: get the total cost and the total discount
  def total_goods(discount_goods)
    total_info = Hash.new
    total_info = {"total_cost"=>0,"total_discount"=>0}
    discount_goods.each do |item|
      total_info["total_cost"] += item["total_price"]
      total_info["total_discount"] += item["discount"]
    end
    total_info

  end #  def total_goods    end


# task6: print the shopping list
  def shopping_list(discount_goods,total_info)
    p "***<没钱赚商店>购物清单***"
    discount_goods.each do |item|
      p "名称："+item["name"]+"，数量："+item["count"].to_s+item["unit"]+"，单价："+item["price"].to_s+"(元)，小计："+item["total_price"].to_s+"(元)"
    end
    p "----------------------"
    p "挥泪赠送商品："
    discount_goods.each do |item|
      if item["discount"] != 0
        p "名称："+item["name"]+"，数量："+(item["count"]-item["new_count"]).to_s+item["unit"]
      end
    end
    p "----------------------"
    p "总计："+total_info["total_cost"].to_s+"(元)"
    p "节省："+total_info["total_discount"].to_s+"(元)"
    p "**********************"

  end   #   def shopping_list   end


end # class    end

#pos_goods = CountGoods.new
#goods = JSON.parse(File.read('../spec/fixture/goods-example.json'))
#all_goods = JSON.parse(File.read('../spec/fixture/all-items.json'))
#goods_buy = pos_goods.count_item(goods)
#goods_detail = pos_goods.item_detail(all_goods,goods_buy)
#promotions = JSON.parse(File.read('../spec/fixture/promotions.json'))
#prom_barcode = pos_goods.promotion_item(promotions)
#discount_goods = pos_goods.youhui_goods(goods_detail,prom_barcode)
#total_info = pos_goods.total_goods(discount_goods)
#pos_goods.shopping_list(discount_goods,total_info)
