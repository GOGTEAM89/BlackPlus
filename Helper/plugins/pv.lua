--[[
     **************************
     *  BlackPlus Plugins...  *
     *                        *
     *     By @SubProcess     *
     *                        *
     *  Channel > @SubCreator *
     **************************
	 
]]
local function is_sudo(msg, chat_id)
    local var = false
    for k,v in pairs(config.sudo_users) do
        if msg.from.id == v then
            var = true
        end
    end
  return var
end

function pv_Adminpanel()
   local keyboard = {
      {"1"},
      {"1", "2"},
      {"1"}
   }
    return keyboard
end
-----------------------------------------------------------------------------------------------
local action = function(msg, blocks)
    if is_sudo(msg) then
	    if blocks[1] == 'reload' then
	        bot_init(true)
	    	api.sendReply(msg, "*Bot Reloaded!*", true)
		end
	end
    if blocks[1] == 'start' then
		api.sendReply(msg, "*Hi* ", true)
    end
    
end

return {
	admin_not_needed = true,
	triggers = {
	    config.Cmd..'(start)$',
	    config.Cmd..'(reload)$',
	    config.Cmd..'(panel)$',
    },
	action = action,
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