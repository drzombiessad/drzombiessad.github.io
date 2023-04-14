-- enable cross-origin resource sharing
game:GetService("HttpService").CorsPolicy = "HttpPolicy"

-- URL to the free UGC item
local itemURL = "https://www.roblox.com/catalog/13108629127/Free-UGC-Item"

-- price range to filter out non-free UGC items
local minPrice = 0
local maxPrice = 0

-- function to check if an item is a UGC item
local function isUGC(item)
    return item.AssetTypeId == Enum.AssetType.UserGeneratedContent
end

-- function to check if an item is free
local function isFree(item)
    return item.PriceInRobux == 0
end

-- function to find the UGC item
local function findUGC()
    local cursor = nil
    repeat
        local items = game:GetService("MarketplaceService"):GetProductsAsync(nil, nil, cursor)
        for _, item in ipairs(items) do
            if isUGC(item) and isFree(item) and item.AssetLink == itemURL then
                return item
            end
        end
        cursor = items[#items].Cursor
    until not cursor
end

-- function to buy the UGC item
local function buyUGC()
    local item = findUGC()
    if item then
        game:GetService("MarketplaceService"):PurchaseProduct(item.ProductId, Enum.InfoType.Product)
        print("Successfully bought UGC item:", item.Name)
    else
        print("Could not find UGC item with URL:", itemURL)
    end
end

-- call the buyUGC function
buyUGC()
