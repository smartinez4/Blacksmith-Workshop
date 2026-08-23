this.blacksmith_workshop_enter_event <- this.inherit(
"scripts/events/event",
    {
        m = {},

        function create() {
            this.m.ID = "event.location.blacksmith_workshop_enter";
            this.m.Title = "Blacksmith's Workshop";
            this.m.IsSpecial = true;

            this.m.Screens.push({
                ID = "A",

                Text = "[img]gfx/ui/events/event_05.png[/img]"
                    + "The ringing of hammer against steel grows louder as you approach the secluded workshop. "
                    + "Heat rolls from the open forge, carrying with it the smell of coal and hot iron.\n\n"
                    + "A broad-shouldered blacksmith looks up from his work.\n\n"
                    + "\"Looking for something better than the usual market rubbish?\"",

                Image = "",
                List = [],
                Characters = [],

                Options = [
                {
                    Text = "Commission a famed weapon.",

                    function getResult( _event )
                    {
                        return "WeaponMenu";
                    }
                },

                {
                    Text = "Commission a famed suit of armor.",

                    function getResult( _event )
                    {
                        ::logInfo("Blacksmith Workshop: Armor commission selected.");

                        if (::BlacksmithWorkshop.giveRandomNamedArmor())
                        {
                            return "ArmorReceived";
                        }

                        return "Failed";
                    }
                },

                {
                    Text = "Commission a famed helmet.",

                    function getResult( _event )
                    {
                        if (::BlacksmithWorkshop.giveRandomNamedHelmet())
                        {
                            return "HelmetReceived";
                        }

                        return "Failed";
                    }
                },

                {
                    Text = "Commission a famed shield.",

                    function getResult( _event )
                    {
                        ::logInfo("Blacksmith Workshop: Shield commission selected.");

                        if (::BlacksmithWorkshop.giveRandomNamedShield())
                        {
                            return "ShieldReceived";
                        }

                        return "Failed";
                    }
                },

                {
                    Text = "Perhaps another time.",

                    function getResult( _event )
                    {
                        return 0;
                    }
                }
                ],

                function start(_event) {
                }
            });

            this.m.Screens.push({
                ID = "WeaponMenu",

                Text = "[img]gfx/ui/events/event_05.png[/img]"
                    + "The blacksmith folds his arms and looks toward the weapon racks lining the walls.\n\n"
                    + "\"What sort of weapon are you after?\"",

                Image = "",
                List = [],
                Characters = [],

                Options = [
                {
                    Text = "A sword.",

                    function getResult( _event )
                    {
                        if (::BlacksmithWorkshop.giveRandomNamedWeaponType("Sword"))
                        {
                            return "WeaponReceived";
                        }

                        return "Failed";
                    }
                },

                {
                    Text = "An axe.",

                    function getResult( _event )
                    {
                        if (::BlacksmithWorkshop.giveRandomNamedWeaponType("Axe"))
                        {
                            return "WeaponReceived";
                        }

                        return "Failed";
                    }
                },

                {
                    Text = "A mace.",

                    function getResult( _event )
                    {
                        if (::BlacksmithWorkshop.giveRandomNamedWeaponType("Mace"))
                        {
                            return "WeaponReceived";
                        }

                        return "Failed";
                    }
                },

                {
                    Text = "A hammer.",

                    function getResult( _event )
                    {
                        if (::BlacksmithWorkshop.giveRandomNamedWeaponType("Hammer"))
                        {
                            return "WeaponReceived";
                        }

                        return "Failed";
                    }
                },

                {
                    Text = "More weapon types.",

                    function getResult( _event )
                    {
                        return "WeaponMenu2";
                    }
                },

                {
                    Text = "Never mind.",

                    function getResult( _event )
                    {
                        return "A";
                    }
                }
                ],

                function start( _event )
                {
                }
            });

            this.m.Screens.push({
                ID = "WeaponMenu2",

                Text = "[img]gfx/ui/events/event_05.png[/img]"
                    + "The smith gestures toward another rack near the back of the forge.\n\n"
                    + "\"Anything here catch your eye?\"",

                Image = "",
                List = [],
                Characters = [],

                Options = [
                {
                    Text = "A cleaver.",

                    function getResult( _event )
                    {
                        if (::BlacksmithWorkshop.giveRandomNamedWeaponType("Cleaver"))
                        {
                            return "WeaponReceived";
                        }

                        return "Failed";
                    }
                },

                {
                    Text = "A flail.",

                    function getResult( _event )
                    {
                        if (::BlacksmithWorkshop.giveRandomNamedWeaponType("Flail"))
                        {
                            return "WeaponReceived";
                        }

                        return "Failed";
                    }
                },

                {
                    Text = "A spear.",

                    function getResult( _event )
                    {
                        if (::BlacksmithWorkshop.giveRandomNamedWeaponType("Spear"))
                        {
                            return "WeaponReceived";
                        }

                        return "Failed";
                    }
                },

                {
                    Text = "A polearm.",

                    function getResult( _event )
                    {
                        if (::BlacksmithWorkshop.giveRandomNamedWeaponType("Polearm"))
                        {
                            return "WeaponReceived";
                        }

                        return "Failed";
                    }
                },

                {
                    Text = "A dagger.",

                    function getResult( _event )
                    {
                        if (::BlacksmithWorkshop.giveRandomNamedWeaponType("Dagger"))
                        {
                            return "WeaponReceived";
                        }

                        return "Failed";
                    }
                },

                {
                    Text = "Back.",

                    function getResult( _event )
                    {
                        return "WeaponMenu";
                    }
                }
                ],

                function start( _event )
                {
                }
            });

            this.m.Screens.push({
                ID = "WeaponReceived",

                Text = "[img]gfx/ui/events/event_05.png[/img]"
                    + "The blacksmith disappears into the workshop. "
                    + "After some time, he returns carrying a weapon wrapped in thick cloth.\n\n"
                    + "\"There. Try not to get yourself killed with it.\"",

                Image = "",
                List = [],
                Characters = [],

                Options = [
                {
                    Text = "Take the weapon.",

                    function getResult(_event) {
                        return 0;
                    }
                }
                ],

                function start(_event) {
                }
            });

            this.m.Screens.push({
                ID = "ArmorReceived",

                Text = "[img]gfx/ui/events/event_05.png[/img]"
                    + "The blacksmith studies you for a moment before disappearing deeper into the workshop. "
                    + "Some time later, he returns carrying a carefully fitted piece of armor.\n\n"
                    + "\"Good steel. Better workmanship. Don't waste it.\"",

                Image = "",
                List = [],
                Characters = [],

                Options = [
                {
                    Text = "Take the armor.",

                    function getResult( _event )
                    {
                        return 0;
                    }
                }
                ],

                function start( _event )
                {
                }
            });

            this.m.Screens.push({
                ID = "HelmetReceived",

                Text = "[img]gfx/ui/events/event_05.png[/img]"
                    + "The smith sets a newly finished helmet onto the table and gives the metal a hard knock with his knuckles.\n\n"
                    + "\"Keep your head inside this and you may live long enough to buy from me again.\"",

                Image = "",
                List = [],
                Characters = [],

                Options = [
                {
                    Text = "Take the helmet.",

                    function getResult( _event )
                    {
                        return 0;
                    }
                }
                ],

                function start( _event )
                {
                }
            });

            this.m.Screens.push({
                ID = "ShieldReceived",

                Text = "[img]gfx/ui/events/event_05.png[/img]"
                    + "The smith disappears behind the forge. "
                    + "When he returns, he sets a newly finished shield before you with a heavy thud.\n\n"
                    + "\"If this breaks, whatever hit it was probably going to kill you anyway.\"",

                Image = "",
                List = [],
                Characters = [],

                Options = [
                {
                    Text = "Take the shield.",

                    function getResult( _event )
                    {
                        return 0;
                    }
                }
                ],

                function start( _event )
                {
                }
            });


            this.m.Screens.push({
                ID = "Failed",

                Text = "[img]gfx/ui/events/event_05.png[/img]"
                    + "The blacksmith frowns and shakes his head.\n\n"
                    + "\"Something went wrong. Come back later.\"",

                Image = "",
                List = [],
                Characters = [],

                Options = [
                {
                    Text = "Leave.",

                    function getResult(_event) {
                        return 0;
                    }
                }
                ],

                function start(_event) {
                }
            });
        }

        function onUpdateScore() {
        }

        function onPrepare() {
        }

        function onPrepareVariables(_vars) {
        }

        function onClear() {
        }
    }
);