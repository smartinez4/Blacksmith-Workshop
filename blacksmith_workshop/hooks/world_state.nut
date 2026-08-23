::BlacksmithWorkshop.hasWorkshop <- function()
{
    local locations = ::World.EntityManager.getLocations();

    foreach (location in locations)
    {
        if (location.getTypeID() == "location.blacksmith_workshop")
        {
            local tile = location.getTile();

            ::logInfo(
            "Blacksmith Workshop: Existing workshop coordinates: "
                + tile.SquareCoords.X
                + ", "
                + tile.SquareCoords.Y
            );

            local nearestSettlement = null;
            local nearestDistance = 9999;

            foreach (settlement in ::World.EntityManager.getSettlements())
            {
                local distance =
                tile.getDistanceTo(settlement.getTile());

                if (distance < nearestDistance)
                {
                    nearestDistance = distance;
                    nearestSettlement = settlement;
                }
            }

            if (nearestSettlement != null)
            {
                ::logInfo(
                "Blacksmith Workshop: Nearest settlement is "
                    + nearestSettlement.getName()
                    + " at distance "
                    + nearestDistance
                );
            }

            return true;
        }
    }

    return false;
};


::BlacksmithWorkshop.findSpawnTile <- function()
{
    local settlements = ::World.EntityManager.getSettlements();

    if (settlements.len() == 0)
    {
        ::logError("Blacksmith Workshop: No settlements found.");
        return null;
    }

    // Pick a random settlement as our search origin.
    local settlement = settlements[::Math.rand(0, settlements.len() - 1)];

    local originTile = settlement.getTile();

    local navSettings = ::World.getNavigator().createSettings();

    navSettings.ActionPointCosts = ::Const.World.TerrainTypeNavCost_Flat;


    for (local attempt = 0; attempt < 500; ++attempt)
    {
        local x = ::Math.rand(
        ::Math.max(2, originTile.SquareCoords.X - 15),
            ::Math.min(
            ::Const.World.Settings.SizeX - 2,
                originTile.SquareCoords.X + 15
            )
        );

        local y = ::Math.rand(
        ::Math.max(2, originTile.SquareCoords.Y - 15),
            ::Math.min(
            ::Const.World.Settings.SizeY - 2,
                originTile.SquareCoords.Y + 15
            )
        );

        if (!::World.isValidTileSquare(x, y))
        {
            continue;
        }

        local tile = ::World.getTileSquare(x, y);

        if (tile.IsOccupied)
        {
            continue;
        }

        if (
        tile.Type == ::Const.World.TerrainType.Ocean ||
            tile.Type == ::Const.World.TerrainType.Shore ||
            tile.Type == ::Const.World.TerrainType.Mountains
        )
        {
            continue;
        }

        local distance = tile.getDistanceTo(originTile);

        if (distance < 6 || distance > 15)
        {
            continue;
        }

        local path = ::World.getNavigator().findPath(
        tile,
            originTile,
            navSettings,
            0
        );

        if (path.isEmpty())
        {
            continue;
        }

        return tile;
    }

    return null;
};


::BlacksmithWorkshop.spawnWorkshop <- function()
{
    if (::BlacksmithWorkshop.hasWorkshop())
    {
        ::logInfo("Blacksmith Workshop: Workshop already exists.");
        return;
    }

    local tile = ::BlacksmithWorkshop.findSpawnTile();

    if (tile == null)
    {
        ::logError("Blacksmith Workshop: Could not find valid spawn tile.");
        return;
    }

    ::logInfo(
    "Blacksmith Workshop: Spawning workshop at "
        + tile.SquareCoords.X
        + ", "
        + tile.SquareCoords.Y
    );

    local workshop = ::World.spawnEntity(
    "scripts/entity/world/locations/blacksmith_workshop_location",
        tile.Coords.X,
        tile.Coords.Y
    );

    // DEBUG: Find nearest settlement
    local nearestSettlement = null;
    local nearestDistance = 9999;

    foreach (settlement in ::World.EntityManager.getSettlements())
    {
        local distance = tile.getDistanceTo(settlement.getTile());

        if (distance < nearestDistance)
        {
            nearestDistance = distance;
            nearestSettlement = settlement;
        }
    }

    if (nearestSettlement != null)
    {
        ::logInfo(
        "Blacksmith Workshop: Nearest settlement is "
            + nearestSettlement.getName()
            + " at distance "
            + nearestDistance
        );
    }

    ::logInfo(
    "Blacksmith Workshop: Spawn successful."
    );
};


::mods_addHook("onCampaignLoaded", function(_worldState)
{
    ::BlacksmithWorkshop.spawnWorkshop();
});