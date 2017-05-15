class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    item_resp = find_item(req.path)

    if item_resp == "Route not found"
      resp.status = 404
      resp.write item_resp
    elsif item_resp == "Item not found"
      resp.status = 400
      resp.write item_resp

    else
      resp.write   item_resp
    end

    resp.finish

  end

  def find_item(path)
    if !@@items.empty?

      @@items.each do |item|
        if path == "/items/#{item.name}"
          return item.price
        end
      end
      if path.match(/items/)
        "Item not found"
      else
        "Route not found"
      end
    else
      "Route not found"
    end
  end

end
