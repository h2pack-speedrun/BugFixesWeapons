table.insert(option_fns,
    {
        type = "checkbox",
        configKey = "TidalRingFix",
        label = "Tidal Ring Fix",
        default = true,
        tooltip =
        "Fixes Tidal Ring not hitting the same mob twice with Circe."
    })
table.insert(apply_fns, {
    key = "TidalRingFix",
    fn = function()
        if not ProjectileData or not ProjectileData.PoseidonCastSplashSplinter then return end
        backup(ProjectileData.PoseidonCastSplashSplinter, "ImmunityDuration")
        ProjectileData.PoseidonCastSplashSplinter.ImmunityDuration = 0
    end
})
