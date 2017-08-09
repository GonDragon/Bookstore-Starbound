function init()
  self.buyFactor = config.getParameter("buyFactor", root.assetJson("/merchant.config").defaultBuyFactor)

  object.setInteractive(true)
end

function onInteraction(args)
  local interactData = config.getParameter("interactData")
  interactData.recipes = {}

  local storeInventory = config.getParameter("storeInventory")
  addRecipes(interactData, storeInventory.novels, "novels")
  addRecipes(interactData, storeInventory.manuals, "manuals")
  addRecipes(interactData, storeInventory.history, "history")

  return { "OpenCraftingInterface", interactData }
end

function addRecipes(interactData, items, category)
  for i, item in ipairs(items) do
    interactData.recipes[#interactData.recipes + 1] = generateRecipe(item, category)
  end
end

function generateRecipe(itemName, category)
  return {
    input = { {"money", math.floor(self.buyFactor * (root.itemConfig(itemName).config.price or root.assetJson("/merchant.config").defaultItemPrice))} },
    output = itemName,
    groups = { category }
  }
end
