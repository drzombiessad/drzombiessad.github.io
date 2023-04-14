local limitedId = 4786877411 -- Replace with the ID of the limited item you want to buy
local currencyType = Enum.CurrencyType.Robux -- Change to Enum.CurrencyType.Tix if you want to use tickets instead of Robux
local price = 89 -- Replace with the maximum price you are willing to pay for the item

local player = game.Players.LocalPlayer
local marketplaceService = game:GetService("MarketplaceService")

local success, productId = pcall(function()
    return marketplaceService:GetProductInfo(limitedId)
end)

if success then
    local success2, purchaseable = pcall(function()
        return marketplaceService:UserOwnsGamePassAsync(player.UserId, limitedId)
    end)

    if success2 and not purchaseable then
        local success3, priceInfo = pcall(function()
            return marketplaceService:GetProductPrice(limitedId, currencyType)
        end)

        if success3 and priceInfo and priceInfo >= price then
            local success4, purchaseResult = pcall(function()
                return marketplaceService:PromptPurchase(player, limitedId, currencyType)
            end)

            if success4 and purchaseResult == Enum.PurchaseResult.Success then
                print("Successfully purchased limited item with ID:", limitedId)
            else
                warn("Failed to purchase limited item with ID:", limitedId)
            end
        else
            warn("The limited item with ID:", limitedId, "is either not for sale, or is too expensive")
        end
    else
        warn("You already own the limited item with ID:", limitedId)
    end
else
    warn("Invalid limited item ID:", limitedId)
end
