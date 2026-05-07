local internal = BugFixesWeaponsInternal
local option_fns = internal.option_fns
local patch_fns = internal.patch_fns

table.insert(option_fns,
    {
        type = "checkbox",
        alias = "ExtraDoseFix",
        label = "Extra Dose Fix",
        default = true,
        tooltip =
        "Fixes Extra Dose interaction with Coat 2nd punch and Dash strike."
    })
table.insert(patch_fns, {
    key = "ExtraDoseFix",
    fn = function(plan)
        if not TraitData.DoubleStrikeChanceBoon then return end
        local propertyChanges = TraitData.DoubleStrikeChanceBoon.PropertyChanges
        if type(propertyChanges) ~= "table" then return end
        if type(propertyChanges[1]) ~= "table" or type(propertyChanges[4]) ~= "table" then return end
        plan:appendUnique(propertyChanges[1], "WeaponNames", "WeaponSuit2")
        plan:appendUnique(propertyChanges[1], "WeaponNames", "WeaponSuitDash")
        plan:appendUnique(propertyChanges[4], "WeaponNames", "WeaponSuit2")
        plan:appendUnique(propertyChanges[4], "WeaponNames", "WeaponSuitDash")
    end
})
