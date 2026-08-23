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


::BlacksmithWorkshop.giveItemToStash <- function(_item)
{
    if (_item == null)
    {
        return false;
    }

    local stash = ::World.Assets.getStash();

    if (!stash.add(_item))
    {
        ::logError("Blacksmith Workshop: Could not add item to stash.");

        return false;
    }

    ::logInfo("Blacksmith Workshop: Added famed item to stash: " + _item.getName());

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
    ::BlacksmithWorkshop.createRandomNamedArmor()
    );
};


::BlacksmithWorkshop.giveRandomNamedHelmet <- function()
{
    return ::BlacksmithWorkshop.giveItemToStash(
    ::BlacksmithWorkshop.createRandomNamedHelmet()
    );
};


::BlacksmithWorkshop.giveRandomNamedShield <- function()
{
    return ::BlacksmithWorkshop.giveItemToStash(
    ::BlacksmithWorkshop.createRandomNamedShield()
    );
};


// ---------------------------------------------------------
// WEAPON FAMILY FILTERING
// ---------------------------------------------------------
::BlacksmithWorkshop.getNamedWeaponPoolByCategory <- function(_category)
{
    local result = [];

    foreach (weaponPath in ::Const.Items.NamedMeleeWeapons)
    {
        local item = ::new("scripts/items/" + weaponPath);

        if (!("Categories" in item.m))
        {
            continue;
        }

        local categories = item.m.Categories;

        ::logInfo("Blacksmith Workshop: Checking " + weaponPath + " - category: " + categories);

        if (categories.find(_category) == 0)
        {
            result.push(weaponPath);
        }
    }

    return result;
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
    )
    );
};