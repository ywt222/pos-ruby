require 'rubygems'
require 'json'
require 'pp'


# task1:count the items in goods-example.json
class CountGoods
  def count_item
    goods = File.read('../spec/fixture/goods-example.json')
    goods_example = JSON.parse(goods)

    @goods_buy = Hash.new
    goods_example.each do |item|
      value = 0
      barcode = item.split('-')[0]
      num = item.split('-')[1]
      if num != nil
        value += num.to_i
      else
        value += 1
      end
      if @goods_buy.keys.include?("#{barcode}")
        @goods_buy["#{barcode}"] += value
      else
        @goods_buy["#{barcode}"] = value
      end
    end
    @goods_buy
  end


# task2:load all items from all-items.json
  def item_detail
    all = File.read('../spec/fixture/all-items.json')
    all_goods = JSON.parse(all)
    goods_buy_array = Array.new
    goods_buy_array = @goods_buy.to_a
    goods_detail = Array.new
    @all_goods_ini = Array.new

    all_goods.each do |item|
      @all_goods_ini << item.merge("count"=>0)
    end

# 46-52行也可为54-60行
    @all_goods_ini.each do |i|
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

    @all_goods_ini.each do |item|
      if item["count"] != 0
        goods_detail << item
      end
    end

    goods_detail

  end # def item_detail   end

end # class    end

#a = CountGoods.new
#a.count_item
#a.item_detail
