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

                Text = "[img]gfx/ui/events/event_115.png[/img]"
                    + "The ringing of hammer against steel grows louder as you approach the secluded workshop. "
                    + "Heat rolls from the open forge, carrying with it the smell of coal and hot iron.\n\n"
                    + "A broad-shouldered blacksmith looks up from his work.\n\n"
                    + "%SPEECH_ON%Looking for something better than the usual market rubbish?%SPEECH_OFF%",

                Image = "",
                List = [],
                Characters = [],

                Options = [
                {
                    Text = "Commission a famed weapon (%weapon_commission_cost% crowns).",

                    function getResult( _event )
                    {
                        local failureScreen = ::BlacksmithWorkshop.getCommissionFailureScreen("Weapon");

                        if (failureScreen != null)
                        {
                            return failureScreen;
                        }

                        return "WeaponMenu";
                    }
                },

                {
                    Text = "Commission a famed suit of armor (%armor_commission_cost% crowns).",

                    function getResult( _event )
                    {
                        local failureScreen = ::BlacksmithWorkshop.getCommissionFailureScreen("Armor");

                        if (failureScreen != null)
                        {
                            return failureScreen;
                        }

                        ::logInfo("Blacksmith Workshop: Armor commission selected.");

                        if (::BlacksmithWorkshop.giveRandomNamedArmor())
                        {
                            return "ArmorReceived";
                        }

                        return ::BlacksmithWorkshop.getLastCommissionFailureScreen();
                    }
                },

                {
                    Text = "Commission a famed helmet (%helmet_commission_cost% crowns).",

                    function getResult( _event )
                    {
                        local failureScreen = ::BlacksmithWorkshop.getCommissionFailureScreen("Helmet");

                        if (failureScreen != null)
                        {
                            return failureScreen;
                        }

                        if (::BlacksmithWorkshop.giveRandomNamedHelmet())
                        {
                            return "HelmetReceived";
                        }

                        return ::BlacksmithWorkshop.getLastCommissionFailureScreen();
                    }
                },

                {
                    Text = "Commission a famed shield (%shield_commission_cost% crowns).",

                    function getResult( _event )
                    {
                        local failureScreen = ::BlacksmithWorkshop.getCommissionFailureScreen("Shield");

                        if (failureScreen != null)
                        {
                            return failureScreen;
                        }

                        ::logInfo("Blacksmith Workshop: Shield commission selected.");

                        if (::BlacksmithWorkshop.giveRandomNamedShield())
                        {
                            return "ShieldReceived";
                        }

                        return ::BlacksmithWorkshop.getLastCommissionFailureScreen();
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
                ID = "RenownRequired",

                Text = "[img]gfx/ui/events/event_115.png[/img]"
                    + "The ringing of hammer against steel grows louder as you approach the secluded workshop. "
                    + "The blacksmith glances at your company, but does not set down his hammer."
                    + "%SPEECH_ON%Can’t say I’ve heard your name before. I don’t waste good steel on just anyone. Come back when your name carries some weight.%SPEECH_OFF%"
                    + "He turns back to the anvil, making it clear that there will be no business today.\n\n"
                    + "Requires %minimum_renown% renown.",

                Image = "",
                List = [],
                Characters = [],

                Options = [
                {
                    Text = "Leave.",

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
                ID = "CannotAffordWeapon",

                Text = "[img]gfx/ui/events/event_115.png[/img]"
                    + "The blacksmith names his price and shakes his head when he sees your purse.\n\n"
                    + "%SPEECH_ON%Fine work does not come cheap. Bring %weapon_commission_cost% crowns and then we'll talk.%SPEECH_OFF%",

                Image = "",
                List = [],
                Characters = [],

                Options = [
                {
                    Text = "Leave.",

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
                ID = "CannotAffordArmor",

                Text = "[img]gfx/ui/events/event_115.png[/img]"
                    + "The blacksmith names his price and shakes his head when he sees your purse.\n\n"
                    + "%SPEECH_ON%A suit worthy of a legend takes time and exceptional steel. Bring %armor_commission_cost% crowns and then we'll talk.%SPEECH_OFF%",

                Image = "",
                List = [],
                Characters = [],

                Options = [
                {
                    Text = "Leave.",

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
                ID = "CannotAffordHelmet",

                Text = "[img]gfx/ui/events/event_115.png[/img]"
                    + "The blacksmith names his price and shakes his head when he sees your purse.\n\n"
                    + "%SPEECH_ON%If you want the finest steel guarding your head, bring %helmet_commission_cost% crowns.%SPEECH_OFF%",

                Image = "",
                List = [],
                Characters = [],

                Options = [
                {
                    Text = "Leave.",

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
                ID = "CannotAffordShield",

                Text = "[img]gfx/ui/events/event_115.png[/img]"
                    + "The blacksmith names his price and shakes his head when he sees your purse.\n\n"
                    + "%SPEECH_ON%A shield like this is no common plank. Bring %shield_commission_cost% crowns and then we'll talk.%SPEECH_OFF%",

                Image = "",
                List = [],
                Characters = [],

                Options = [
                {
                    Text = "Leave.",

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
                ID = "CommissionCooldown",

                Text = "[img]gfx/ui/events/event_115.png[/img]"
                    + "The blacksmith shakes his head and turns back to the forge.\n\n"
                    + "%SPEECH_ON%Quality takes time. Your next commission will have to wait.%SPEECH_OFF%"
                    + "Come back in %cooldown_wait%.",

                Image = "",
                List = [],
                Characters = [],

                Options = [
                {
                    Text = "Leave.",

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
                ID = "WeaponMenu",

                Text = "[img]gfx/ui/events/event_115.png[/img]"
                    + "The blacksmith folds his arms and looks toward the weapon racks lining the walls.\n\n"
                    + "%SPEECH_ON%What sort of weapon are you after?%SPEECH_OFF%",

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

                        return ::BlacksmithWorkshop.getLastCommissionFailureScreen();
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

                        return ::BlacksmithWorkshop.getLastCommissionFailureScreen();
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

                        return ::BlacksmithWorkshop.getLastCommissionFailureScreen();
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

                        return ::BlacksmithWorkshop.getLastCommissionFailureScreen();
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

                Text = "[img]gfx/ui/events/event_115.png[/img]"
                    + "The smith gestures toward another rack near the back of the forge.\n\n"
                    + "%SPEECH_ON%Anything here catch your eye?%SPEECH_OFF%",

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

                        return ::BlacksmithWorkshop.getLastCommissionFailureScreen();
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

                        return ::BlacksmithWorkshop.getLastCommissionFailureScreen();
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

                        return ::BlacksmithWorkshop.getLastCommissionFailureScreen();
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

                        return ::BlacksmithWorkshop.getLastCommissionFailureScreen();
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

                        return ::BlacksmithWorkshop.getLastCommissionFailureScreen();
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

                Text = "[img]gfx/ui/events/event_115.png[/img]"
                    + "The blacksmith disappears into the workshop. "
                    + "After some time, he returns carrying a weapon wrapped in thick cloth.\n\n"
                    + "%SPEECH_ON%There. Try not to get yourself killed with it.%SPEECH_OFF%",

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
                    _event.addCommissionResultToList(this.List);
                }
            });

            this.m.Screens.push({
                ID = "ArmorReceived",

                Text = "[img]gfx/ui/events/event_115.png[/img]"
                    + "The blacksmith studies you for a moment before disappearing deeper into the workshop. "
                    + "Some time later, he returns carrying a carefully fitted piece of armor.\n\n"
                    + "%SPEECH_ON%Good steel. Better workmanship. Don't waste it.%SPEECH_OFF%",

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
                    _event.addCommissionResultToList(this.List);
                }
            });

            this.m.Screens.push({
                ID = "HelmetReceived",

                Text = "[img]gfx/ui/events/event_115.png[/img]"
                    + "The smith sets a newly finished helmet onto the table and gives the metal a hard knock with his knuckles.\n\n"
                    + "%SPEECH_ON%Keep your head inside this and you may live long enough to buy from me again.%SPEECH_OFF%",

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
                    _event.addCommissionResultToList(this.List);
                }
            });

            this.m.Screens.push({
                ID = "ShieldReceived",

                Text = "[img]gfx/ui/events/event_115.png[/img]"
                    + "The smith disappears behind the forge. "
                    + "When he returns, he sets a newly finished shield before you with a heavy thud.\n\n"
                    + "%SPEECH_ON%If this breaks, whatever hit it was probably going to kill you anyway.%SPEECH_OFF%",

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
                    _event.addCommissionResultToList(this.List);
                }
            });


            this.m.Screens.push({
                ID = "InventoryFull",

                Text = "[img]gfx/ui/events/event_115.png[/img]"
                    + "The blacksmith looks from the finished commission to your overstuffed pack and scowls.\n\n"
                    + "%SPEECH_ON%What am I supposed to do with it, hang it around your neck? Clear some space in that damned pack and come back%SPEECH_OFF%",

                Image = "",
                List = [],
                Characters = [],

                Options = [
                {
                    Text = "Leave.",

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

                Text = "[img]gfx/ui/events/event_115.png[/img]"
                    + "The blacksmith frowns and shakes his head.\n\n"
                    + "%SPEECH_ON%Something went wrong. Come back later.%SPEECH_OFF%",

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

        function addCommissionResultToList( _list )
        {
            local item = ::BlacksmithWorkshop.getLastCommissionedItem();

            if (item == null)
            {
                return;
            }

            _list.push({
                id = 10,
                icon = "ui/items/" + item.getIcon(),
                text = "You gain "
                    + ::Const.Strings.getArticle(item.getName())
                    + item.getName()
            });

            local cost = ::BlacksmithWorkshop.getLastCommissionCost();

            _list.push({
                id = 10,
                icon = "ui/icons/asset_money.png",
                text = "You spend [color="
                    + ::Const.UI.Color.NegativeEventValue
                    + "]"
                    + cost
                    + "[/color] Crowns"
            });
        }

        function onUpdateScore() {
        }

        function onPrepare() {
        }

        function onDetermineStartScreen()
        {
            if (!::BlacksmithWorkshop.meetsRenownRequirement())
            {
                return "RenownRequired";
            }

            if (::BlacksmithWorkshop.isCommissionOnCooldown())
            {
                return "CommissionCooldown";
            }

            return "A";
        }

        function onPrepareVariables(_vars) {
            _vars.push([
                "minimum_renown",
                ::BlacksmithWorkshop.getMinimumRenown()
            ]);

            _vars.push([
                "weapon_commission_cost",
                ::BlacksmithWorkshop.getCommissionCost("Weapon")
            ]);

            _vars.push([
                "armor_commission_cost",
                ::BlacksmithWorkshop.getCommissionCost("Armor")
            ]);

            _vars.push([
                "helmet_commission_cost",
                ::BlacksmithWorkshop.getCommissionCost("Helmet")
            ]);

            _vars.push([
                "shield_commission_cost",
                ::BlacksmithWorkshop.getCommissionCost("Shield")
            ]);

            local cooldownDays = ::BlacksmithWorkshop.getDaysUntilNextCommission();

            _vars.push([
                "cooldown_wait",
                cooldownDays + (cooldownDays == 1 ? " day" : " days")
            ]);
        }

        function onClear() {
        }
    }
);
