-- luacheck: globals BugFixesWeaponsInternal public
local internal = BugFixesWeaponsInternal

public.definition.patchPlan = function(plan, activeStore)
    if internal.BuildPatchPlan then
        internal.BuildPatchPlan(plan, activeStore)
    end
end

function internal.BuildPatchPlan(plan, activeStore)
    for _, b in ipairs(internal.patch_fns) do
        if activeStore.read(b.key) and b.fn then
            b.fn(plan)
        end
    end
end

function internal.RegisterHooks()
    for _, fn in ipairs(internal.hook_fns) do
        fn()
    end
end

return internal
