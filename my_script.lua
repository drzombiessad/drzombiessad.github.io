local http = game:GetService("HttpService")
local Players = game:GetService("Players")
local username = "drzombiessad"
local password = "jaeyunbhuh"
local item_name = "Invalid Bling Necklace"

local function search_item_price()
  local url = string.format("https://search.roblox.com/catalog/json?Category=9&SortType=0&Subcategory=14&Keyword=%s&ResultsPerPage=10", http:UrlEncode(item_name))
  local response = http:RequestAsync({Url = url, Method = "GET"})
  local results = http:JSONDecode(response.Body).Items
  
  for i, item in ipairs(results) do
    if item.Name == item_name and item.PriceInRobux == 0 then
      return item
    end
  end
end

local function login()
  local success, response = pcall(function()
    Players:CreateLocalPlayer(0)
    Players.LocalPlayer:LoadCharacter()
    game:GetService("RunService"):Run()
  end)
  
  if not success then
    warn("Error creating local player: " .. response)
    return
  end
  
  game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
  
  local success, response = pcall(function()
    game:GetService("Players"):SetChatStyle(Enum.ChatStyle.ClassicAndBubble)
    game:GetService("Players"):Chat("login " .. username .. " " .. password)
  end)
  
  if not success then
    warn("Error logging in: " .. response)
  end
end

local function purchase_item()
  local item = search_item_price()
  if not item then
    warn("No free UGC items found with the name: " .. item_name)
    return
  end
  
  local market_place = game:GetService("MarketplaceService")
  local product_info = market_place:GetProductInfo(item.AssetId, Enum.InfoType.Product)
  local success, response = pcall(function()
    market_place:PromptPurchase(Players.LocalPlayer, product_info.ProductId)
  end)
  
  if not success then
    warn("Error purchasing item: " .. response)
  end
end

login()
purchase_item()
