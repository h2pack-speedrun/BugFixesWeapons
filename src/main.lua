local mods = rom.mods
mods["SGG_Modding-ENVY"].auto()

---@diagnostic disable: lowercase-global
rom = rom
_PLUGIN = _PLUGIN
game = rom.game
modutil = mods["SGG_Modding-ModUtil"]
local chalk = mods["SGG_Modding-Chalk"]
local reload = mods["SGG_Modding-ReLoad"]
lib = mods["adamant-ModpackLib"]

local dataDefaults = import("config.lua")
local config = chalk.auto("config.lua")

local PACK_ID = "speedrun"

BugFixesWeaponsInternal = BugFixesWeaponsInternal or {}
local internal = BugFixesWeaponsInternal

public.definition = {
    modpack = PACK_ID,
    id = "BugFixesWeapons",
    name = "Bug Fixes: Weapons",
    tooltip = "Weapon-related fixes for speedrun consistency.",
    default = dataDefaults.Enabled,
    affectsRunData = true,
}

public.host = nil
local store
local session
internal.standaloneUi = nil

local function init()
    import_as_fallback(rom.game)

    import("data.lua")
    import("logic.lua")
    import("ui.lua")

    store, session = lib.createStore(config, public.definition, dataDefaults)
    internal.store = store

    if internal.RegisterHooks then
        internal.RegisterHooks()
    end

    public.host = lib.createModuleHost({
        definition = public.definition,
        store = store,
        session = session,
        drawTab = internal.DrawTab,
    })
    internal.standaloneUi = lib.standaloneHost(public.host)
end

local loader = reload.auto_single()

modutil.once_loaded.game(function()
    loader.load(init, init)
end)

---@diagnostic disable-next-line: redundant-parameter
rom.gui.add_imgui(function()
    if internal.standaloneUi and internal.standaloneUi.renderWindow then
        internal.standaloneUi.renderWindow()
    end
end)

---@diagnostic disable-next-line: redundant-parameter
rom.gui.add_to_menu_bar(function()
    if internal.standaloneUi and internal.standaloneUi.addMenuBar then
        internal.standaloneUi.addMenuBar()
    end
end)
