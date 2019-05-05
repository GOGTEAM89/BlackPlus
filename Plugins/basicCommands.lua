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
	local function id_by_reply(extra, result, success)
	    user_msgs = redis:get('bot:'..msg_.bot_id..':user:msgs'..msg.chat_id..':'..result.sender_user_id) or 0
		sendMsg(msg.chat_id, msg.id, "*آیدی کاربر:* `"..result.sender_user_id.."`\n*تعداد پیام های ارسالی کاربر:* `"..user_msgs.."`", "md")
	end
    ---------------------------------------------------------
	local function id_by_username(extra, result, success)
  		if result.id then
		    user_msgs = redis:get('bot:'..msg_.bot_id..':user:msgs'..msg.chat_id..':'..result.id) or 0
		    sendMsg(msg.chat_id, msg.id, "*آیدی شخص:* `"..result.id.."`\n*تعداد پیام های ارسالی کاربر:* `"..user_msgs.."`", "md")
   	 	else
		    sendMsg(msg.chat_id, msg.id, "*کاربر یافت نشد!*\n_لطفا آیدی مورد نظر را بررسی کنید و دوباره تلاش کنید._", "md")
  		end
	end
    ---------------------------------------------------------
	local function id_by_id(user_id)
	    user_msgs = redis:get('bot:'..msg_.bot_id..':user:msgs'..msg.chat_id..':'..user_id) or 0
		sendMsg(msg.chat_id, msg.id, "*آیدی شخص:* `"..user_id.."`\n*تعداد پیام های ارسالی کاربر:* `"..user_msgs.."`", "md")
	end
    ---------------------------------------------------------
	if is_sleep(msg) or msg.chat_type == "pv" then
	    return false
	end
    if matches[1] == 'id' or matches[1] == 'ایدی' or matches[1] == 'آیدی' then
		if not matches[2] and msg.reply then
	        getMessage(msg.chat_id, msg.reply, id_by_reply)
	    elseif matches[2] and is_number(matches[2]) then
		    id_by_id(matches[2])
	    elseif matches[2] and not is_number(matches[2]) then
	    	resolve_username(matches[2], id_by_username)
	    else
		    user_msgs = redis:get('bot:'..msg_.bot_id..':user:msgs'..msg.chat_id..':'..msg.sender_user_id) or 0
			sendMsg(msg.chat_id, msg.id, "*آیدی گروه:* `"..msg.chat_id.."`\n*آیدی شما:* `"..msg.sender_user_id.."`\n*تعداد پیام های ارسالی شما:* `"..user_msgs.."`", "md")
		end
		botMessages(nil, msg)
	---------------------------------------------------------
	elseif matches[1] == 'iclean' or matches[1] == 'حذف پیام های من' then
		function dllCallback(extra, result, success)
    	    if result.results and result.results[0] then
			    sendInlineQuery(msg.chat_id, msg.id, result.inline_query_id, result.results[0].id)
       		else
        	    sendMsg(msg.chat_id, msg.id, '*خطایی در ارتباط با ربات دستیار رخ داده است⚠️*\n_لطفا کمی صبر کنید و دوباره تلاش کنید_','md')
      	 	end
        end
		if not redis:get("last:delall:"..msg.sender_user_id) then 
	    	redis:setex("last:delall:"..msg.sender_user_id, 3600, true)
		    getInlineResult(msg_.helper_id, msg.chat_id, "BPDALL:"..msg.chat_id.."/"..msg.sender_user_id.."/"..msg_.bot_id, dllCallback)
		end
	---------------------------------------------------------
	elseif matches[1] == 'ping' and not is_mod(msg) or matches[1] == 'ربات' and not is_mod(msg) then
	    botMessages(nil, msg)
		return "*ربات روشن است!*"
	---------------------------------------------------------
	elseif matches[1] == 'me' or matches[1] == 'من' then
		function userPhotoResults(arg, data)
		    user_msgs = redis:get('bot:'..msg_.bot_id..':user:msgs'..msg.chat_id..':'..msg.sender_user_id) or 0
		    unumb = (redis:get("b:"..msg_.bot_id..":"..msg.chat_id..":"..msg.sender_user_id) or 0)
		    if data.photos and data.photos[0] then
			    sendPhoto(msg.chat_id, msg.id, data.photos[0].sizes[2].photo.persistent_id, "آیدی گروه: "..msg.chat_id.."\nآیدی شما: "..msg.sender_user_id.."\nتعداد پیام های ارسالی شما: "..user_msgs.."\nتعداد کاربران ادد شده توسط شما: "..unumb)
			else
			    sendMsg(msg.chat_id, msg.id, "*آیدی گروه:* `"..msg.chat_id.."`\n*آیدی شما:* `"..msg.sender_user_id.."`\n*تعداد پیام های ارسالی شما:* `"..user_msgs.."`\n*تعداد کاربران ادد شده توسط شما:* `"..unumb.."`", "md")
			end
		end
		botMessages(nil, msg)
		getUserProfilePhotos(msg.sender_user_id, 0, 1, userPhotoResults)
    ---------------------------------------------------------
	end
end

return {
    Commands = {
        _config.Cmd..'(id) (.*)$',
        _config.Cmd..'(id)$',
		'^(ایدی) (.*)$',
		'^(آیدی) (.*)$',
		'^(ایدی)$',
		'^(آیدی)$',
		_config.Cmd..'(ping)$',
        '^ربات$',
		_config.Cmd..'(me)$',
        '^من$',
		_config.Cmd..'(iclean)$',
		'^(حذف پیام های من)$',
    },
	Procces = {
	    sensitivity = false,
		singCommands = true,
		editedCommands = true
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