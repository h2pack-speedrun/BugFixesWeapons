table.insert(option_fns,
    {
        type = "checkbox",
        configKey = "StagedOmegaFix",
        label = "Axe and Blade Omega Channel Fix",
        default = true,
        tooltip =
        "Fixes Axe OAtk, Blade OSpec not benefiting correctly from channeling bonus."
    })
table.insert(apply_fns, {
    key = "StagedOmegaFix",
    fn = function()
        backup(WeaponData.WeaponDaggerThrow, "MinWeaponChargeTime")
        backup(WeaponData.WeaponAxeSpin, "MinWeaponChargeTime")
        WeaponData.WeaponDaggerThrow.MinWeaponChargeTime = 0.05
        WeaponData.WeaponAxeSpin.MinWeaponChargeTime     = 0.05
    end
})
