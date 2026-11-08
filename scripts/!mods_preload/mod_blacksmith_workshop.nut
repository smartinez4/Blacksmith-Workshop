::BlacksmithWorkshop <- {
    ID = "mod_blacksmith_workshop",
    Version = "1.1.2",
    Name = "Blacksmith's Workshop"
};

local mod = ::Hooks.register(
    ::BlacksmithWorkshop.ID,
    ::BlacksmithWorkshop.Version,
    ::BlacksmithWorkshop.Name
);

::BlacksmithWorkshop.HooksMod <- mod;

mod.require(
    "mod_modern_hooks (Modern Hooks)",
    "mod_msu >= 1.2.0 (Modding Standards & Utilities)"
);

mod.queue(">mod_msu", function()
{
    ::BlacksmithWorkshop.Mod <- ::MSU.Class.Mod(
        ::BlacksmithWorkshop.ID,
        ::BlacksmithWorkshop.Version,
        ::BlacksmithWorkshop.Name
    );

    ::include("blacksmith_workshop/config");
    ::include("blacksmith_workshop/weapon_pools");
    ::include("blacksmith_workshop/blacksmith_manager");
    ::include("blacksmith_workshop/hooks/world_state");
});
