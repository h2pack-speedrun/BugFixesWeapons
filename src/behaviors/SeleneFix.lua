table.insert(option_fns,
    {
        type = "checkbox",
        configKey = "SeleneFix",
        label = "Aspect of Selene Fix",
        default = true,
        tooltip =
        "Aspect of Selene properly registers its hex so you get offered PoS directly. Skyfall is full moonglow."
    })

local function DeepCompare(a, b)
    if a == b then return true end
    if type(a) ~= type(b) then return false end
    if type(a) ~= "table" then return false end
    for key, value in pairs(a) do
        if not DeepCompare(value, b[key]) then return false end
    end
    for key in pairs(b) do
        if a[key] == nil then return false end
    end
    return true
end

local function ListContainsEquivalent(list, template)
    if type(list) ~= "table" then return false end
    for _, entry in ipairs(list) do
        if DeepCompare(entry, template) then return true end
    end
    return false
end

table.insert(apply_fns, {
    key = "SeleneFix",
    fn = function()
        backup(NamedRequirementsData, "SpellDropRequirements")
        local seleneReq = {
            PathFalse = { "CurrentRun", "Hero", "TraitDictionary", "SuitHexAspect" }
        }
        if not ListContainsEquivalent(NamedRequirementsData.SpellDropRequirements, seleneReq) then
            table.insert(NamedRequirementsData.SpellDropRequirements, seleneReq)
        end
    end
})

table.insert(hook_fns, function()
    modutil.mod.Path.Wrap("StartNewRun", function(baseFunc, prevRun, args)
        if not config.SeleneFix or not lib.isEnabled(config, public.definition.modpack) then
            return baseFunc(prevRun, args)
        end
        local currentRun = baseFunc(prevRun, args)
        if HeroHasTrait("SuitHexAspect") then
            RecordUse(nil, "SpellDrop")
        end
        return currentRun
    end)

    modutil.mod.Path.Wrap("SpawnRoomReward", function(baseFunc, eventSource, args)
        if not config.SeleneFix or not lib.isEnabled(config, public.definition.modpack) then
            return baseFunc(eventSource, args)
        end
        if HeroHasTrait("SuitHexAspect") and HeroHasTrait("SpellTalentKeepsake") and game.CurrentRun.CurrentRoom.BiomeStartRoom then
            args = args or {}
            if args.WaitUntilPickup then
                args.RewardOverride = "TalentDrop"
                args.LootName = nil
            end
        end
        return baseFunc(eventSource, args)
    end)
end)
