::BlacksmithWorkshop.createRandomNamedItem <- function(_pool)
{
    if (_pool == null || _pool.len() == 0)
    {
        ::logError("Blacksmith Workshop: Named item pool is empty!");
        return null;
    }

    local index = ::Math.rand(0, _pool.len() - 1);
    local itemPath = _pool[index];

    ::logInfo("Blacksmith Workshop: Creating scripts/items/" + itemPath);

    local item = ::new("scripts/items/" + itemPath);

    return item;
};


::BlacksmithWorkshop.LastCommissionFailureScreen <- "Failed";
::BlacksmithWorkshop.LastCommissionedItem <- null;
::BlacksmithWorkshop.LastCommissionCost <- 0;


::BlacksmithWorkshop.getLastCommissionFailureScreen <- function()
{
    return ::BlacksmithWorkshop.LastCommissionFailureScreen;
};


::BlacksmithWorkshop.getLastCommissionedItem <- function()
{
    return ::BlacksmithWorkshop.LastCommissionedItem;
};


::BlacksmithWorkshop.getLastCommissionCost <- function()
{
    return ::BlacksmithWorkshop.LastCommissionCost;
};


::BlacksmithWorkshop.giveItemToStash <- function(_item, _category)
{
    ::BlacksmithWorkshop.LastCommissionFailureScreen = "Failed";
    ::BlacksmithWorkshop.LastCommissionedItem = null;
    ::BlacksmithWorkshop.LastCommissionCost = 0;

    if (_item == null)
    {
        return false;
    }

    if (!::BlacksmithWorkshop.meetsRenownRequirement())
    {
        ::logError("Blacksmith Workshop: Company does not meet the renown requirement.");
        return false;
    }

    if (::BlacksmithWorkshop.isCommissionOnCooldown())
    {
        ::logError("Blacksmith Workshop: Commission is still on cooldown.");
        return false;
    }

    if (!::BlacksmithWorkshop.canAffordCommission(_category))
    {
        ::logError("Blacksmith Workshop: Company cannot afford the commission.");
        return false;
    }

    local stash = ::World.Assets.getStash();

    if (!stash.add(_item))
    {
        ::logError("Blacksmith Workshop: Could not add item to stash.");
        ::BlacksmithWorkshop.LastCommissionFailureScreen = "InventoryFull";

        return false;
    }

    local cost = ::BlacksmithWorkshop.getCommissionCost(_category);
    ::BlacksmithWorkshop.LastCommissionedItem = _item;
    ::BlacksmithWorkshop.LastCommissionCost = cost;
    ::World.Assets.addMoney(-cost);
    ::BlacksmithWorkshop.recordCommission();

    ::logInfo(
        "Blacksmith Workshop: Added famed item to stash: "
            + _item.getName()
            + " for "
            + cost
            + " crowns."
    );

    return true;
};


// ---------------------------------------------------------
// GENERIC ITEM CATEGORIES
// ---------------------------------------------------------

::BlacksmithWorkshop.createRandomNamedArmor <- function()
{
    return ::BlacksmithWorkshop.createRandomNamedItem(
    ::Const.Items.NamedArmors
    );
};


::BlacksmithWorkshop.createRandomNamedHelmet <- function()
{
    return ::BlacksmithWorkshop.createRandomNamedItem(
    ::Const.Items.NamedHelmets
    );
};


::BlacksmithWorkshop.createRandomNamedShield <- function()
{
    return ::BlacksmithWorkshop.createRandomNamedItem(
    ::Const.Items.NamedShields
    );
};


::BlacksmithWorkshop.giveRandomNamedArmor <- function()
{
    return ::BlacksmithWorkshop.giveItemToStash(
    ::BlacksmithWorkshop.createRandomNamedArmor(),
    "Armor"
    );
};


::BlacksmithWorkshop.giveRandomNamedHelmet <- function()
{
    return ::BlacksmithWorkshop.giveItemToStash(
    ::BlacksmithWorkshop.createRandomNamedHelmet(),
    "Helmet"
    );
};


::BlacksmithWorkshop.giveRandomNamedShield <- function()
{
    return ::BlacksmithWorkshop.giveItemToStash(
    ::BlacksmithWorkshop.createRandomNamedShield(),
    "Shield"
    );
};


// ---------------------------------------------------------
// WEAPON FAMILY FILTERING
// ---------------------------------------------------------
::BlacksmithWorkshop.getNamedWeaponPoolByCategory <- function(_category)
{
    if (!(_category in ::BlacksmithWorkshop.NamedWeaponPools))
    {
        ::logError("Blacksmith Workshop: Unknown weapon category " + _category);
        return [];
    }

    return ::BlacksmithWorkshop.NamedWeaponPools[_category];
};


::BlacksmithWorkshop.createRandomNamedWeaponType <- function(_category)
{
    local pool =
    ::BlacksmithWorkshop.getNamedWeaponPoolByCategory(
    _category
    );

    if (pool.len() == 0)
    {
        ::logError(
        "Blacksmith Workshop: No famed weapons found for category "
            + _category
        );

        return null;
    }

    ::logInfo("Blacksmith Workshop: " + _category + " category contains " + pool.len() + " possible items.");

    return ::BlacksmithWorkshop.createRandomNamedItem(pool);
};


::BlacksmithWorkshop.giveRandomNamedWeaponType <- function(_category)
{
    return ::BlacksmithWorkshop.giveItemToStash(
    ::BlacksmithWorkshop.createRandomNamedWeaponType(
    _category
    ),
    "Weapon"
    );
};
