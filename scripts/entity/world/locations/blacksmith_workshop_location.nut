this.blacksmith_workshop_location <- this.inherit(
"scripts/entity/world/location",
    {
        m = {},

        function getDescription()
        {
            return "A secluded workshop belonging to a master blacksmith.";
        }

        function create()
        {
            this.location.create();

            this.m.Name = "Blacksmith's Workshop";
            this.m.TypeID = "location.blacksmith_workshop";

            this.m.LocationType = this.Const.World.LocationType.Unique;

            this.m.IsShowingDefenders = false;
            this.m.IsShowingBanner = false;
            this.m.IsAttackable = false;
            this.m.IsDespawningDefenders = false;

            this.m.VisibilityMult = 1.0;
            this.m.Resources = 0;

            this.m.OnEnter = "event.location.blacksmith_workshop_enter";
        }

        function onInit()
        {
            this.location.onInit();

            local body = this.addSprite("body");

            // TEMPORARY vanilla sprite.
            body.setBrush("world_fortress_ruins");
        }

        function onEnter()
        {
            ::logInfo("Blacksmith Workshop: Entered workshop.");

            ::World.Events.fire("event.location.blacksmith_workshop_enter");

            return false;
        }

        function onDeserialize( _in )
        {
            this.location.onDeserialize(_in);

            this.m.OnEnter = "event.location.blacksmith_workshop_enter";
            this.m.IsAttackable = false;
        }
    }
);