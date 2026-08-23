local page = ::BlacksmithWorkshop.Mod.ModSettings.addPage(
    "Balance",
    "Balance"
);

page.addRangeSetting(
    "MinimumRenown",
    3000,
    0,
    10000,
    250,
    "Minimum Renown",
    "Renown required before the company may commission famed items."
);

page.addRangeSetting(
    "WeaponCommissionCost",
    50000,
    0,
    200000,
    1000,
    "Weapon Commission Cost",
    "Crowns charged for a famed weapon."
);

page.addRangeSetting(
    "ArmorCommissionCost",
    70000,
    0,
    200000,
    1000,
    "Armor Commission Cost",
    "Crowns charged for a famed suit of body armor."
);

page.addRangeSetting(
    "HelmetCommissionCost",
    45000,
    0,
    200000,
    1000,
    "Helmet Commission Cost",
    "Crowns charged for a famed helmet."
);

page.addRangeSetting(
    "ShieldCommissionCost",
    35000,
    0,
    200000,
    1000,
    "Shield Commission Cost",
    "Crowns charged for a famed shield."
);

page.addRangeSetting(
    "CommissionCooldownDays",
    20,
    0,
    100,
    1,
    "Commission Cooldown",
    "Days the company must wait between successful commissions."
);


::BlacksmithWorkshop.getMinimumRenown <- function()
{
    return ::BlacksmithWorkshop.Mod.ModSettings
        .getSetting("MinimumRenown")
        .getValue();
};


::BlacksmithWorkshop.getCommissionCost <- function(_category)
{
    local settingID = null;

    switch (_category)
    {
        case "Weapon":
            settingID = "WeaponCommissionCost";
            break;

        case "Armor":
            settingID = "ArmorCommissionCost";
            break;

        case "Helmet":
            settingID = "HelmetCommissionCost";
            break;

        case "Shield":
            settingID = "ShieldCommissionCost";
            break;

        default:
            ::logError("Blacksmith Workshop: Unknown commission category " + _category);
            return null;
    }

    return ::BlacksmithWorkshop.Mod.ModSettings
        .getSetting(settingID)
        .getValue();
};


::BlacksmithWorkshop.getCommissionCooldownDays <- function()
{
    return ::BlacksmithWorkshop.Mod.ModSettings
        .getSetting("CommissionCooldownDays")
        .getValue();
};


::BlacksmithWorkshop.getDaysUntilNextCommission <- function()
{
    local flag = "BlacksmithWorkshop.LastCommissionDay";

    if (!::World.Flags.has(flag))
    {
        return 0;
    }

    local elapsedDays = ::World.getTime().Days - ::World.Flags.get(flag);
    return ::Math.max(
        0,
        ::BlacksmithWorkshop.getCommissionCooldownDays() - elapsedDays
    );
};


::BlacksmithWorkshop.isCommissionOnCooldown <- function()
{
    return ::BlacksmithWorkshop.getDaysUntilNextCommission() > 0;
};


::BlacksmithWorkshop.recordCommission <- function()
{
    ::World.Flags.set(
        "BlacksmithWorkshop.LastCommissionDay",
        ::World.getTime().Days
    );
};


::BlacksmithWorkshop.meetsRenownRequirement <- function()
{
    return ::World.Assets.getBusinessReputation()
        >= ::BlacksmithWorkshop.getMinimumRenown();
};


::BlacksmithWorkshop.canAffordCommission <- function(_category)
{
    local cost = ::BlacksmithWorkshop.getCommissionCost(_category);

    return cost != null && ::World.Assets.getMoney() >= cost;
};


::BlacksmithWorkshop.getCommissionFailureScreen <- function(_category)
{
    if (::BlacksmithWorkshop.getCommissionCost(_category) == null)
    {
        return "Failed";
    }

    if (!::BlacksmithWorkshop.meetsRenownRequirement())
    {
        return "RenownRequired";
    }

    if (::BlacksmithWorkshop.isCommissionOnCooldown())
    {
        return "CommissionCooldown";
    }

    if (!::BlacksmithWorkshop.canAffordCommission(_category))
    {
        return "CannotAfford" + _category;
    }

    return null;
};
