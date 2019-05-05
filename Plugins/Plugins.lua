--[[
     **************************
     *  BlackPlus Plugins...  *
     *                        *
     *     By @SubProcess     *
     *                        *
     *  Channel > @SubCreator *
     **************************
	 
]]
local Plugin = function(msg, matches)
------------------------------------------------------------------------
    if not is_admin(msg) then
	    return false
	end
  ------------------------------------------------------------------------
    if matches[1] == 'plugins' and not matches[2] then 
	botMessages(nil, msg)
    local text = '*لیست پلاگین های ربات:*\n*➖➖➖➖➖➖➖➖➖➖*\n'
    local nsum = 0
        for k, v in pairs( plugins_names( )) do
            local status = '[غیر فعال | ✖️]'
            nsum = nsum+1
            nact = 0
            for k2, v2 in pairs(_config.plugins) do
                if v == v2..'.lua' then 
                    status = '[فعال | ✔️]' 
                end
                nact = nact+1
            end
            if not only_enabled or status == '[فعال | ✔️]' then
                v = string.match (v, "(.*)%.lua")
                text = text..k..' - *'..v..' -> *`'..status..'`\n'
            end
        end
        local text = text..'➖➖➖➖➖➖➖➖➖➖\n🔃*از*  '..nsum..' *پلاگین موجود،* '..nact..' *پلاگین فعال شده است و* '..nsum-nact..' *پلاگین غیرفعال است.*'
      return text
    end
  ------------------------------------------------------------------------
    if matches[1] == 'plugins' then
	botMessages(nil, msg)
        if matches[2] == 'disable' and matches[3] then
            local text = ""  
            if matches[3] == 'Plugins' then
                text = '*خطا!\nشما نمیتوانید این پلاگین را غیر فعال کنید...*'
            elseif not is_found(matches[3]) then
                text = '*پلاگین* `'..matches[3]..'` *در پوشه پلاگین های ربات شما موجود نمیباشد*'
            elseif not is_plugin_enabled(matches[3]) then
	            text = "*پلاگین* `"..matches[3].."` *از قبل غیرفعال است!*"
            else
                table.remove(_config.plugins, is_plugin_enabled(matches[3]))
                save_config()
	            plugins = {}
                load_plugins()
                text = "*پلاگین* `"..matches[3].."` *با موفقیت غیرفعال شد!*"
	        end
			return text
	    elseif matches[2] == 'enable' and matches[3] then
	        local text = ""
            if is_plugin_enabled(matches[3]) then
	            text = "*پلاگین* `"..matches[3].."` *از قبل فعال است!*"
            elseif not is_found(matches[3]) then
                text = '*پلاگین* `'..matches[3]..'` *در پوشه پلاگین های ربات شما موجود نمیباشد*'
	        else
                table.insert(_config.plugins, matches[3])
	            text = "*پلاگین* `"..matches[3].."` *با موفقیت فعال شد!*"
                save_config()
	            plugins = {}
                load_plugins()
            end
			return text
	    end
   end
  ------------------------------------------------------------------------
    if matches[1] == 'reload' then 
	botMessages(nil, msg)
        plugins = {}
        load_plugins()
	  return "*ربات با موفقیت بروزرسانی شد و تغییرات اعمال شد✅*"
    end
end

return {
    Commands = {
	    _config.Cmd..'(plugins) (enable) (.*)$',
        _config.Cmd..'(plugins) (disable) (.*)$',
        _config.Cmd..'(plugins)$',
        _config.Cmd..'(reload)$',
	},
	Procces = {
	    sensitivity = false,
		singCommands = false
	},
	parse_mode = "md", -- ["md","html","normal"]
    Plugin = Plugin
}
--[[
     **************************
     *  BlackPlus Plugins...  *
     *                        *
     *     By @SubProcess     *
     *                        *
     *  Channel > @SubCreator *
     **************************
	 
]]