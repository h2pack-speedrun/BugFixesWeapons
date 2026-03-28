table.insert(option_fns,
    {
        type = "checkbox",
        configKey = "ExtraDoseFix",
        label = "Extra Dose Fix",
        default = true,
        tooltip =
        "Fixes Extra Dose interaction with Coat 2nd punch and Dash strike."
    })
table.insert(apply_fns, {
    key = "ExtraDoseFix",
    fn = function()
        if not TraitData.DoubleStrikeChanceBoon then return end
        backup(TraitData.DoubleStrikeChanceBoon, "PropertyChanges")
        table.insert(TraitData.DoubleStrikeChanceBoon.PropertyChanges[1].WeaponNames, "WeaponSuit2")
        table.insert(TraitData.DoubleStrikeChanceBoon.PropertyChanges[1].WeaponNames, "WeaponSuitDash")
        table.insert(TraitData.DoubleStrikeChanceBoon.PropertyChanges[4].WeaponNames, "WeaponSuit2")
        table.insert(TraitData.DoubleStrikeChanceBoon.PropertyChanges[4].WeaponNames, "WeaponSuitDash")
    end
})
