--[[
File Author: @file-author@
File Revision: @file-revision@
File Date: @file-date-iso@
]]--
local debug = false
--@debug@
debug = true
--@end-debug@

L =  {}
if L then
--@localization(locale="enUS", format="lua_additive_table", same-key-is-true=true, handle-subnamespaces="subtable")@
if GetLocale() == "enUS" then return end
end

if L then
--@localization(locale="zhTW", format="lua_additive_table", same-key-is-true=true, handle-subnamespaces="subtable")@
if GetLocale() == "zhTW" then return end
end
