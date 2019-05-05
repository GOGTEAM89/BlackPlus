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
    ---------------------------------------------------------
    if matches[1] == 'delall' then
	    del_all_msgs(tonumber(matches[2]), tonumber(matches[4]))
	---------------------------------------------------------
    elseif matches[1] == 'getbots' then
	    local function loadBots(FreemanagerBOT,result)
		    local users = result.members
		    local keyboard = {}
            keyboard.inline_keyboard = {
	            {
    	      	   {text = ("برگشت⬅️"), callback_data = ('bp:back:'..matches[2]..':'..matches[4]..":"..msg_.bot_id)},
	            },
            }
		    local num = 0
		    local text
			if result and result.total_count > 0 then
	            for i=0, #users do
                    if not have_rank(tonumber(users[i].user_id),  matches[2]) then
		    			chat_kick(tonumber(matches[2]), tonumber(users[i].user_id))
		    	        num = num + 1
		            end
                end
			end
			if num == 0 then
		        text = "`در این گروه رباتی که مقام نداشته باشد وجود ندارد...`"
		    else
		        text = "*با موفقیت* `"..num.."` *ربات از گروه حذف شد.\nتوجه داشته باشید که ربات هایی که دارای مقام هستند از گروه حذف نمیشوند!*"
            end
			helper_edit(false, matches[3], text, keyboard, true)
        end
		getChannelMembers(matches[2]:gsub('-100', ''), "Bots", 0, 200, loadBots)
	---------------------------------------------------------
    elseif matches[1] == 'cbans' then
	     List = redis:smembers("bot:"..msg_.bot_id..":banned:"..matches[2])
		 for k,v in pairs(List) do
		    restrictUser(tonumber(matches[2]), v, 0, nil, {1,1,1,1,1,1})
		 end
	     redis:del("bot:"..msg_.bot_id..":banned:"..matches[2])
		 Tlist = redis:keys("bot:"..msg_.bot_id..":tbanned:"..matches[2].."*")
		 for k,v in pairs(Tlist) do
		    redis:del(v)
			restrictUser(tonumber(matches[2]), v, 0, nil, {1,1,1,1,1,1})
		 end
	---------------------------------------------------------
    elseif matches[1] == 'cmutes' then
	     List = redis:smembers("bot:"..msg_.bot_id..":muted:"..matches[2])
		 for k,v in pairs(List) do
		    restrictUser(tonumber(matches[2]), v, 0, nil, {1,1,1,1,1,1})
		 end
	     redis:del("bot:"..msg_.bot_id..":muted:"..matches[2])
		 Tlist = redis:keys("bot:"..msg_.bot_id..":tmuted:"..matches[2].."*")
		 for k,v in pairs(Tlist) do
		    redis:del(v)
			restrictUser(tonumber(matches[2]), v, 0, nil, {1,1,1,1,1,1})
		 end
	---------------------------------------------------------
    end
end

return {
    Commands = {
        '^##(delall):G=(.*):m_id=(.*):user_id=(.*)##$',
        '^##(getbots):G=(.*):m_id=(.*):user_id=(.*)##$',
        '^##(cbans):G=(.*):m_id=(.*):user_id=(.*)##$',
        '^##(cmutes):G=(.*):m_id=(.*):user_id=(.*)##$',
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