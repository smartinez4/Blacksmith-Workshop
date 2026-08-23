::BlacksmithWorkshop <- {
    ID = "mod_blacksmith_workshop",
    Version = "0.1.0",
    Name = "Blacksmith's Workshop"
};

local mod = ::Hooks.register(
    ::BlacksmithWorkshop.ID,
    ::BlacksmithWorkshop.Version,
    ::BlacksmithWorkshop.Name
);

::BlacksmithWorkshop.Mod <- mod;

mod.queue(function()
{
    ::include("blacksmith_workshop/blacksmith_manager");
    ::include("blacksmith_workshop/hooks/world_state");
});