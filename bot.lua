--[[
     **************************
     *   BlackPlus Source...  *
     *                        *
     *     By @SubProcess     *
     *                        *
     * Channel > @SubCreator  *
     **************************
	 
]]
  redis = require('redis')
  JSON = require('dkjson')
  curl = require('cURL')
  clr = require('term.colors')
  serpent = require('serpent')
  HTTP = require('socket.http')
  HTTPS = require('ssl.https')
  URL = require('socket.url') 
  redis = redis.connect('127.0.0.1', 6379)
  day = 86400
  ------------------------------------------------- 
function dl_cb(arg, data)
end
  ------------------------------------------------- 
function vardump(value)
    Print("-----------------------------------")
    Print(serpent.block(value, {comment=false}))
    Print("-----------------------------------")
end
  ------------------------------------------------- 
function Print(value, k)
    if _config.print == true then
	    if k then
	        print(value, k .. "\n")
	    else
	        print(value .. "\n")
	    end
	end
end
  ------------------------------------------------- 
function getTime(sec)
    local T
    if sec >= 86400 then
	    T = math.floor(sec / 86400) + 1 .. " روز"
	elseif sec >= 3600 then
	    T = math.floor(sec / 3600) + 1 .. " ساعت"
	elseif sec >= 60 then
	    T = math.floor(sec / 60) + 1 .. " دقیقه"
	elseif sec < 60 then
	    T = (sec) + 1 .. " ثانیه"
	end
	return T
end
  ------------------------------------------------- 
function is_number(txt)
	local var = tonumber(txt)
	if var then
		return true
	else
		return false
	end
end
  ------------------------------------------------- 
function scandir(directory)
    local i, t, popen = 0, {}, io.popen
    for filename in popen('ls -a "' .. directory .. '"'):lines() do
        i = i + 1
        t[i] = filename
    end
  return t
end
  ------------------------------------------------- 
function plugins_names()
    local files = {}
    for k, v in pairs(scandir('Plugins')) do
        if (v:match(".lua$")) then
            table.insert(files, v)
        end
    end
  return files
end
  ------------------------------------------------- 
function is_found( name )
    for k,v in pairs(plugins_names()) do
        if name..'.lua' == v then
            return true
        end
    end
  return false
end
  ------------------------------------------------- 
function is_plugin_enabled( name )
    for k,v in pairs(_config.plugins) do
        if name == v then
            return k
        end
    end
  return false
end
  ------------------------------------------------- 
function is_channel_disabled(receiver)
	if not _config.expired_groups then
		return false
	end
	if _config.expired_groups[receiver] == nil then
		return false
	end
  return _config.expired_groups[receiver]
end
  ------------------------------------------------- 
function enable_channel(receiver, to_id)
	if not _config.expired_groups then
		_config.expired_groups = {}
	end
	if _config.expired_groups[receiver] == nil then
		return
	end
	_config.expired_groups[receiver] = false
	save_config()
	return
end
  ------------------------------------------------- 
function disable_channel(receiver, to_id)
	if not _config.expired_groups then
		_config.expired_groups = {}
	end
	_config.expired_groups[receiver] = true
	save_config()
	return
end
  ------------------------------------------------- 
function is_sudo(msg)
    local var = false
    for k,v in pairs(_config.sudo_users) do
        if msg.sender_user_id == v then
            var = true
        end
    end
  return var
end
  ------------------------------------------------- 
function is_admin(msg)
    local var = false
	local hashs =  'bot:'..msg_.bot_id..':global:admins'
    local admin = redis:sismember(hashs, msg.sender_user_id)
	if admin then
	    var = true
	elseif is_sudo(msg) then
        var = true
    end
  return var
end
  ------------------------------------------------- 
function is_owner(msg)
    local var = false
    local hash =  'bot:'..msg_.bot_id..':owners:'..msg.chat_id
    local owner = redis:sismember(hash, msg.sender_user_id)
	if owner then
	    var = true
	elseif is_sudo(msg) or is_admin(msg) then
	    var = true
	end
  return var
end
  ------------------------------------------------- 
function is_mod(msg)
    local var = false
    local mod = redis:sismember('bot:'..msg_.bot_id..':mods:'..msg.chat_id, msg.sender_user_id)
	if mod then
	    var = true
	elseif is_sudo(msg) or is_admin(msg) or is_owner(msg) then
	    var = true
	elseif msg.sender_user_id == msg_.bot_id or msg.sender_user_id == msg_.helper_id then
	    var = true
	end
  return var
end
  ------------------------------------------------- 
function is_muted(chat_id, user_id)
    local var = false
	if redis:sismember("bot:"..msg_.bot_id..":muted:"..chat_id, user_id) then
	    var = true
	elseif redis:get("bot:"..msg_.bot_id..":tmuted:"..chat_id..":"..user_id) then
	    var = true
	end
  return var
end
  -------------------------------------------------
function is_banned(chat_id, user_id)
    local var = false
	if redis:sismember("bot:"..msg_.bot_id..":banned:"..chat_id, user_id) then
	    var = true
	elseif redis:get("bot:"..msg_.bot_id..":tbanned:"..chat_id..":"..user_id) then
	    var = true
	elseif redis:sismember('bot:'..msg_.bot_id..':global:banned', user_id) then
	    var = true
	end
  return var
end
  ------------------------------------------------- 
function have_rank(user_id, chat_id)
    local var = false
	if redis:sismember('bot:'..msg_.bot_id..':mods:'..chat_id, user_id) then
	    var = true
	elseif redis:sismember('bot:'..msg_.bot_id..':owners:'..chat_id, user_id) then
	    var = true
	elseif redis:sismember('bot:'..msg_.bot_id..':global:admins', user_id) then
	    var = true
	elseif user_id == msg_.bot_id or user_id == msg_.helper_id then
	    var = true
	end
    for k,v in pairs(_config.sudo_users) do
        if user_id == v then
            var = true
        end
	end
    return var
end
  ------------------------------------------------- 
function is_sleep(msg)
    local var = false
	if not is_mod(msg) then
	    if redis:get("bot:"..msg_.bot_id..":locks:all:"..msg.chat_id) then
	        var = true
	    elseif redis:get("bot:"..msg_.bot_id..":locks:cmd:"..msg.chat_id) then
	        var = true
        elseif is_muted(msg.chat_id, msg.sender_user_id) then
	        var = true
	    end
	else
	    var = false
	end
    return var
end
  ------------------------------------------------- 
function is_whitelisted(msg)
    local var = false
	if redis:sismember("bot:"..msg_.bot_id..":whitelist:"..msg.chat_id, msg.sender_user_id) or is_mod(msg) then
	    var = true
	end
    return var
end
  ------------------------------------------------- 
local function getParseMode(parse_mode)
    local P = {}
    if parse_mode then
        local mode = parse_mode:lower()
        if mode == 'markdown' or mode == 'md' then
            P._ = 'textParseModeMarkdown'
        elseif mode == 'html' then
            P._ = 'textParseModeHTML'
        end 
    end
  return P
end
  ------------------------------------------------- 
function setAlarm(sec, callback, data)
    assert (tdbot_function ({
            _ = 'setAlarm',
            seconds = sec
        },  callback or dl_cb, data)
	)
end
  ------------------------------------------------- 
function del_cb(msg, result, success)
    vardump(msg)
	delete_msg(msg.chat_id, {[0] = msg.id})
end
  ------------------------------------------------- 
function botMessages(arg, data)
    if data.chat_id then
   		if redis:get("bot:"..msg_.bot_id..":autodelete:"..data.chat_id) then
	   		local delTime = (redis:get('bot:'..msg_.bot_id..':autodelete:time:'..data.chat_id) or 35)
       		setAlarm(tonumber(delTime), deleteCallbacks, {chat_id = data.chat_id, id = data.id})
		end
	end
end
  ------------------------------------------------- 
function delCB(arg, data)
    setAlarm(3, deleteCallbacks, {chat_id = data.chat_id, id = data.id})
end
  ------------------------------------------------- 
function deleteCallbacks(arg, data)
    delete_msg(arg.chat_id, {[0] = arg.id})
end
  ------------------------------------------------- 
function sendMsg(chat_id, reply_to_message_id, text, parsemode, disablewebpagepreview, cb)
    assert (tdbot_function ({
            _ = 'sendMessage',
            chat_id = chat_id,
            reply_to_message_id = reply_to_message_id,
            disable_notification = 0,
            from_background = 1,
            reply_markup = nil,
            input_message_content = {
                _ = 'inputMessageText',
                text = tostring(text),
                disable_web_page_preview = (disablewebpagepreview or 1),
                parse_mode = getParseMode(parsemode),
                clear_draft = 0,
                entities = nil
            },
        }, cb or botMessages, nil)
	)
end
  ------------------------------------------------- 
function sendContact(chat_id, reply_to_message_id, user_id, phone_number, first_name, last_name)
    assert (tdbot_function ({
            _ = 'sendMessage',
            chat_id = chat_id,
            reply_to_message_id = reply_to_message_id,
            disable_notification = 0,
            from_background = 1,
            reply_markup = nil,
            input_message_content = {
                _ = 'inputMessageContact',
                contact = {
                    _ = 'contact',
                    phone_number = tostring(phone_number),
                    first_name = tostring(first_name),
                    last_name = tostring((last_name or "")),
                    user_id = user_id
                },
            }
        }, callback or dl_cb, nil)
	)
end
  ------------------------------------------------- 
function sendInlineQuery(chatid, replytomessageid, queryid, resultid)
    assert (tdbot_function ({
            _ = 'sendInlineQueryResultMessage',
            chat_id = chatid,
            reply_to_message_id = replytomessageid,
            disable_notification = 0,
            from_background = 1,
            query_id = queryid,
            result_id = tostring(resultid)
        }, dl_cb,nil)
	)
end
  ------------------------------------------------- 
function getInlineResult(bot_user_id, chat_id, query, cb)
    assert (tdbot_function ({
            _ = 'getInlineQueryResults',
            bot_user_id = bot_user_id,
            chat_id = chat_id,
            user_location = {
                _ = 'location',
                latitude = 0,
                longitude = 0 
            },
            query = tostring(query),
            offset = "0"
        }, cb, nil)
	)
end
  ------------------------------------------------- 
function sendBotStart(bot_user_id, parameter)
    assert (tdbot_function ({
	        _ = 'sendBotStartMessage',
			bot_user_id = bot_user_id,
			chat_id = bot_user_id,
			parameter = tostring(parameter)
		},  dl_cb, nil)
	)
end
  ------------------------------------------------- 
function getMe(callback)
  	assert (tdbot_function ({
    	    _ = "getMe",
        }, callback, nil)
	)
end
  ------------------------------------------------- 
function getMessage(chat_id, message_id, callback, data)
    assert (tdbot_function ({
            _ = 'getMessage',
            chat_id = chat_id,
            message_id = message_id
        }, callback or dl_cb, data or nil)
    )
end
  ------------------------------------------------- 
function getUser(user_id, cb, data)
    assert (tdbot_function ({
            _ = 'getUser',
            user_id = user_id
	    }, cb or dl_cb, data or nil)
	)
end
  ------------------------------------------------- 
function getUserFull(user_id, cb, data)
    assert (tdbot_function ({
            _ = "getUserFull",
            user_id = user_id
        }, cb, data or nil)
	)
end
  ------------------------------------------------- 
function getChannelMembers(channel_id, channelMembersFilter, offset, limit, cb)
    assert (tdbot_function ({
            _ = 'getChannelMembers',
            channel_id = channel_id,
            filter = {
                _ = 'channelMembersFilter' .. channelMembersFilter,
            },
            offset = offset,
            limit = limit
        }, cb or dl_cb, nil)
	)
end
  ------------------------------------------------- 
function chat_kick(chat_id, user_id, unban_user, until_date)
  	assert (tdbot_function ({
    	    _ = "changeChatMemberStatus",
    	    chat_id = chat_id,
    	    user_id = user_id,
    	    status = {
      	    	_ = "chatMemberStatusBanned",
				banned_until_date = (until_date or 0)
    	    },
  	    }, dl_cb, nil)
	)
	if(unban_user) then
	    chatUnban(chat_id, user_id)
	end
end
  ------------------------------------------------- 
function delete_msg(chat_id, message_ids)
    assert (tdbot_function ({
            _= "deleteMessages",
            chat_id = chat_id,
            message_ids = message_ids
        }, dl_cb, nil)
	)
end
  ------------------------------------------------- 
function del_all_msgs(chat_id, user_id)
    assert (tdbot_function ({
            _ = "deleteMessagesFromUser",
            chat_id = chat_id,
            user_id = user_id
        }, dl_cb, nil)
	)
end
  ------------------------------------------------- 
function chat_leave(chat_id)
    assert (tdbot_function ({
            _ = "changeChatMemberStatus",
            chat_id = chat_id,
            user_id = msg_.bot_id,
            status = {
                _ = "chatMemberStatusLeft"
            },
        }, dl_cb, nil)
	)
end
  ------------------------------------------------- 
function restrictUser(chat_id, user_id, until_date, cb, extra)
    if not extra then
	    extra = {1,0,0,0,0}
	end
    assert (tdbot_function ({
            _ = 'changeChatMemberStatus',
            chat_id = chat_id,
            user_id = user_id,
            status = {
                is_member = (extra[1] or 1),
                restricted_until_date = until_date or 0,
                can_send_messages = (extra[2] or 0),
                can_send_media_messages = (extra[3] or 0),
                can_send_other_messages = (extra[4] or 0),
                can_add_web_page_previews = (extra[5] or 0),
		        _ = 'chatMemberStatusRestricted'
            }
        }, cb or dl_cb, nil)
	)
end
  ------------------------------------------------- 
function resolve_username(username, cb, data)
    assert (tdbot_function ({
            _ = "searchPublicChat",
            username = username
        }, cb, data or nil)
    )
end
  ------------------------------------------------- 
function chatUnban(chat_id, user_id)
    assert (tdbot_function ({
            _ = "changeChatMemberStatus",
            chat_id = chat_id,
            user_id = user_id,
            status = {
                _ = "chatMemberStatusLeft"
            },
        }, dl_cb, nil)
	)
end
  ------------------------------------------------- 
function getChatHistory(chat_id, from_message_id, limit, cb)
    assert (tdbot_function ({
            _ = "getChatHistory",
            chat_id = chat_id,
            from_message_id = from_message_id,
            offset = 0,
            limit = limit
        }, cb or dl_cb , nil)
	)
end
  ------------------------------------------------- 
function callUser(userid, minlayer, maxlayer, callback, data)
    assert (tdbot_function ({
            _ = 'createCall',
            user_id = userid,
            protocol = {
                _ = 'callProtocol',
                udp_p2p = true,
                udp_reflector = true,
                min_layer = minlayer or 65,
                max_layer = maxlayer or 65
            },
        }, callback or dl_cb, data)
	)
end
  ------------------------------------------------- 
function pinMessage(chat_id, message_id, disablenotification)
    assert (tdbot_function ({
    	    _ = "pinChannelMessage",
  	        channel_id = chat_id,
   	        message_id = message_id,
    	    disable_notification = (disablenotification or 0)
     	}, dl_cb, nil)
	)
end
  ------------------------------------------------- 
function unpinMessage(chat_id)
    assert (tdbot_function ({
    	    _ = 'unpinChannelMessage',
    	    channel_id = chat_id
   	    }, dl_cb, nil)
	)
end
  ------------------------------------------------- 
function blockUser(userid, callback, data)
    assert (tdbot_function ({
            _ = 'blockUser',
            user_id = userid
        }, callback or dl_cb, data or nil)
	)
end
  ------------------------------------------------- 
function unblockUser(userid, callback, data)
    assert (tdbot_function ({
            _ = 'unblockUser',
            user_id = userid
        }, callback or dl_cb, data or nil)
	)
end
  ------------------------------------------------- 
function getUserProfilePhotos(user_id, offset, limit, callback, data)
    assert (tdbot_function ({
            _ = 'getUserProfilePhotos',
            user_id = user_id,
            offset = offset,
            limit = limit
        }, callback or dl_cb, data or nil)
	)
end
  ------------------------------------------------- 
function sendPhoto(chat_id, reply_to_message_id, photo, caption)
    assert (tdbot_function ({
            _= "sendMessage",
            chat_id = chat_id,
            reply_to_message_id = reply_to_message_id,
            disable_notification = 0,
            from_background = 1,
            reply_markup = nil,
            input_message_content = {
                _ = "inputMessagePhoto",
                photo = {
				    _ = 'inputFilePersistentId',
					persistent_id = photo
				},
                added_sticker_file_ids = {},
                width = 0,
                height = 0,
                caption = caption
            },
        }, botMessages, nil)
	)
end
  ------------------------------------------------- 
function openChat(chat_id, callback, data)
    assert (tdbot_function ({
            _ = 'openChat',
            chat_id = chat_id
        }, callback or dl_cb, data or nil)
	)
end
  ------------------------------------------------- 
local curl_context = curl.easy{verbose = false}
  ------------------------------------------------- 
local function performRequest(url)
	local data = {}
	local c = curl_context:setopt_url(url)
		:setopt_writefunction(table.insert, data)
		:perform()
	return table.concat(data), c:getinfo_response_code()
end
  ------------------------------------------------- 
function sendRequest(url)
	local dat, code = performRequest(url)
	local tab = JSON.decode(dat)
	if not tab then
	end
	if code ~= 200 then
		return false
	end
	if not tab.ok then
		return false
	end
	return tab
end
  ------------------------------------------------- 
function helper_getChatMember(chat_id, user_id)
	local url = 'https://api.telegram.org/bot' .. _config.helper.token .. '/getChatMember?chat_id=@' .. chat_id .. '&user_id=' .. user_id
	local res, code, desc = sendRequest(url)
	return res, code
end
  ------------------------------------------------- 
function helper_getMe()
	local url = 'https://api.telegram.org/bot' .. _config.helper.token .. '/getMe'
	local res, code, desc = sendRequest(url)
	return res, code
end
-----------------------------------------------------------------------------------------------
function helper_edit(chat_id, message_id, text, keyboard, markdown, preview)
	local url = 'https://api.telegram.org/bot' .. _config.helper.token 
	if chat_id then
		url = url .. '/editMessageText?chat_id=' .. chat_id .. '&message_id='..message_id..'&text=' .. URL.escape(text)
	else
		url = url .. '/editMessageText?inline_message_id='..message_id..'&text=' .. URL.escape(text)
	end 
	if markdown then
		url = url .. '&parse_mode=Markdown'
	end
	if not preview then
		url = url .. '&disable_web_page_preview=true'
	end
	if keyboard then
		url = url..'&reply_markup='..URL.escape(JSON.encode(keyboard))
	end
	local res, code, desc = sendRequest(url)
	return res, code
end
  ------------------------------------------------- 
function is_JoinedCH(user_id)
    var = true
    status = helper_getChatMember(_config.channel, user_id)
    if status and status.result and status.result.status  then 
        if status.result.status == "left" or status.result.status == "kicked" then
            var = false
        end
    else
        var = false
    end
  return var
end
  -------------------------------------------------
function match_pattern(pattern, text, lower_case)
    if text then
        local matches = {}
        if lower_case then
            matches = { string.match(text:lower(), pattern) }
        else
            matches = { string.match(text, pattern) }
        end
        if next(matches) then
            return matches
        end
    end
end
  ------------------------------------------------- 
function pre_process_service_msg(msg)
    if tonumber(msg.chat_id) then
        local id = tostring(msg.chat_id)
        if id:match('-100(%d+)') then
            msg.chat_type = 'supergroup'
			msg.basic_id = msg.chat_id:gsub('-100', '')
        elseif id:match('^(%d+)') then
            msg.chat_type = 'pv'
			msg.basic_id = msg.chat_id
        end 
    end
	if msg.content and msg.content.entities and msg.content.entities[0] then
	    if msg.content.entities[0].type._ == "textEntityTypeMentionName" then
	        msg.mention = msg.content.entities[0].type.user_id
	    end
	end
	if msg.content and msg.content.entities and msg.content.entities[1] then
	    if msg.content.entities[1].type._ == "textEntityTypeMentionName" then
	        msg.mention = msg.content.entities[1].type.user_id
	    end
	end
	if msg.reply_to_message_id ~= 0 then
	    msg.reply = msg.reply_to_message_id
    end
    if msg.edit_date == 0 then
        if msg.content._ == "messageGame" then
            msg.game = true
        elseif msg.reply_markup and  msg.reply_markup._ == "replyMarkupInlineKeyboard" then
            msg.inline = true
        elseif msg.content._ == "messageText" then
            if msg.content.entities and msg.content.entities[0] and msg.content.entities[0].type._ == "textEntityTypeTextUrl" then
	            msg.hyper =  msg.content.entities[0].type.url
	        end
        --redis:set('bot:editid:'..msg.sender_user_id..':'.. msg.id,msg.content.text)
		--redis:hset("bot:save_history:"..msg.sender_user_id..':'..msg.id, msg.content.text, 'Edit_History')
	        msg.text = msg.content.text or false
        elseif msg.content._ == "messageChatJoinByLink" then
            msg.service = true
            msg.service_type = 'link'
        elseif msg.content._ == "messageChatAddMembers" then
            msg.service = true
            msg.service_user = msg.content.member_user_ids[0]
            msg.service_type = 'invite'
        elseif msg.content._ == "messageChatMigrateFrom" then
            msg.service = true
            msg.service_type = 'tosupergroup'
        elseif msg.content._ == "messageGroupChatCreate" then
            msg.service = true
            msg.service_type = 'create'
        elseif msg.content._ == "messageChatDeleteMember" then
            msg.service = true
            msg.service_type = 'leave'
        elseif msg.content._ == "messagePinMessage" then
            msg.pinned = true
	        msg.pinned_id = msg.id
        elseif msg.content._ == "messagePhoto" then
            msg.photo = true
        elseif msg.content._ == "messageDocument" then
            msg.document = true
        elseif msg.content._ == "messageSticker" then
            msg.sticker = true
        elseif msg.content._ == "messageChatChangeTitle" then
            msg.setname = true
        elseif msg.content._ == "messageChatChangePhoto" then
            msg.setphoto = true
        elseif msg.content._ == "messageAudio" then
            msg.music = true
        elseif msg.content._ == "messageVoice" then
            msg.voice = true
        elseif msg.content._ == "messageVideoNote" then
            msg.vm = true
        elseif msg.content._ == "messageVideo" then
            msg.video = true
        elseif msg.content._ == "messageAnimation" then
            msg.gif = true
        elseif msg.content._ == "messageLocation" then
            msg.location = true
        elseif msg.content._ == "messageContact" then
            msg.contact = true
        elseif msg.content._ == "messageCall" then
            msg.call = true
        else
            Print('--------------* Unknown Method *--------------')
			vardump(msg)
        end
        if msg.content.caption then
     -- redis:set('bot:editid:'..msg.sender_user_id..':'..msg.id,(msg.content.text or msg.content.caption))
	  --redis:hset("bot:save_history:"..msg.sender_user_id..':'..msg.id, (msg.content.text or msg.content.caption), 'Edit_History')
            msg.caption = msg.content.caption or false
        end
        if msg.forward_info then
            msg.fwd = true
        end
    end
    if msg.edit_date ~= 0 then
	    msg.edited = true
	    msg.edit_new_text = msg.content.text or msg.content.caption or false
	    msg.edit_old_text = redis:get('bot:editid:'..msg.sender_user_id..':'..msg.id) or false
		if msg.content.entities and msg.content.entities[0] and msg.content.entities[0].type._ == "textEntityTypeTextUrl" then
	        msg.hyper =  msg.content.entities[0].type.url
	    end
        --redis:set('bot:editid:'..msg.sender_user_id..':'.. msg.id,msg.content.text)
		--redis:hset("bot:save_history:"..msg.sender_user_id..':'..msg.id, msg.content.text, 'Edit_History')
	    msg.text = msg.content.text or false
        if msg.id and msg.content.text or msg.id and msg.content.caption then
	        --redis:set('bot:editid:'..msg.sender_user_id..':'..msg.id, (msg.content.text or msg.content.caption))
	        --redis:hset("bot:save_history:"..msg.sender_user_id..':'..msg.id, (msg.content.text or msg.content.caption), 'Edit_History')
	    end
    end
   return msg
end
  -------------------------------------------------
function match_plugin(plugin, plugin_name, msg)
    for k, pattern in pairs(plugin.Commands) do
	local matches
	    if msg.edited then
		   if plugin.Procces.editedCommands then
		        if plugin.Procces.singCommands then
			        pattern2 = pattern:gsub("%[!/#%]", "")
			     	matches = match_pattern(pattern2, msg.text, plugin.Procces.sensitivity) or match_pattern(pattern, msg.text, plugin.Procces.sensitivity)
			    else
      	            matches = match_pattern(pattern, msg.text, plugin.Procces.sensitivity)
      		    end
		   end
		else
			if plugin.Procces.singCommands then
			    pattern2 = pattern:gsub("%[!/#%]", "")
				matches = match_pattern(pattern2, msg.text, plugin.Procces.sensitivity) or match_pattern(pattern, msg.text, plugin.Procces.sensitivity)
			else
      	        matches = match_pattern(pattern, msg.text, plugin.Procces.sensitivity)
      		end
		end
		if matches then
            Print("Command Detected in Plugin: "..plugin_name..".lua -> ", pattern)
            if plugin.Plugin then
                local result = plugin.Plugin(msg, matches)
                if result then
					sendMsg(msg.chat_id, msg.id, result, "md")
                end
            end
			break
          return
        end
    end
end
  -------------------------------------------------
function match_plugins(msg)
    for name, plugin in pairs(plugins) do
        match_plugin(plugin, name, msg)
    end
end
  -------------------------------------------------
function serialize_to_file(data, file, uglify)
    file = io.open(file, 'w+')
    local serialized
    if not uglify then
        serialized = serpent.block(data, {comment = false, name = '_'})
    else
        serialized = serpent.dump(data)
    end
    file:write(serialized)
    file:close()
end
  -------------------------------------------------
function save_config()
    serialize_to_file(_config, 'config.lua')
end
  -------------------------------------------------
function load_config()
    local config = loadfile("config.lua")()
    print("----------------------------------\n"..clr.onmagenta.."Sudo Users:"..clr.reset)
    for v,user in pairs(config.sudo_users) do
        print(clr.red.."["..v.."]"..clr.reset.." > "..clr.yellow..user..clr.reset)
    end
  return config
end
  -------------------------------------------------
function load_plugins()
    print('----------------------------------')
    print(clr.onmagenta.."Plugins:"..clr.reset)
	print(clr.magenta.."   TDBot - CLI:"..clr.reset)
    for k, v in pairs(_config.plugins) do
        print(clr.red..'        ['..k.."]"..clr.reset" > ", clr.yellow..v..clr.reset)
        local ok, err =  pcall(
		    function()
                local t = loadfile("Plugins/"..v..'.lua')()
                plugins[v] = t
            end
		)
        if not ok then
            print('\27[31mError loading plugin '..v..'\27[39m')
	        print(tostring(io.popen("lua Plugins/"..v..".lua"):read('*all')))
            print('\27[31m'..err..'\27[39m')
        end
    end
	print(clr.magenta.."   Helper- API:"..clr.reset)
	for k, v in pairs(_config.helper.plugins) do
	    print(clr.red..'        ['..k.."]"..clr.reset" > ", clr.yellow..v:gsub(".lua$","")..clr.reset)
	end
        print('----------------------------------')
        print('      Developer > \27[31m@MehdiHS\27[39m')
        print('----------------------------------\n')
end
  -------------------------------------------------
function loadChats()
    assert (tdbot_function ({_="getChats",offset_order="9223372036854775807",offset_chat_id=0,limit=999999}, dl_cb, nil))
	local groups = redis:smembers("bot:"..msg_.bot_id..":groups:")
	if #groups ~= 0 then
        for k,v in pairs(groups) do
	        openChat(v)
	    end
	end
	setAlarm(60, loadChats)
end
  -------------------------------------------------
function startAutoOpenChats()
	setAlarm(1, loadChats)
end
  -------------------------------------------------
function startHelper()
    sendBotStart(msg_.helper_id, "BPPing")
end
  -------------------------------------------------
function pre_process_msg(msg)
    for name,plugin in pairs(plugins) do
        if plugin.pre_process and msg then
            Print('Preprocess in ', name..".lua")
            msg = plugin.pre_process(msg)
        end
    end
  return msg
end
  -------------------------------------------------
function get_me()
    local Hres = helper_getMe()
    local function my_info(txt,data, b)
	    if not Hres then
            print(clr.red..'Helper USER_ID was not detected!!'..clr.reset)
			print(clr.yellow..'      Please check your helper token in config.lua'..clr.reset)
			os.exit()
		elseif not data then
		    print(clr.red..'Bot USER_ID was not detected!!'..clr.reset)
			print(clr.yellow..'      Please delete BlackPlus.TG.config file and try again'..clr.reset)
			os.exit()
		end
		resolve_username(Hres.result.username, dl_cb)
        msg_.bot_id = tonumber(data.id) or false
        msg_.bot_name = data.first_name or false
        msg_.bot_username = data.username or false
        msg_.bot_number = data.phone_number or false
		msg_.helper_id = tonumber(Hres.result.id) or false
        print(clr.green..'Bot Running!'..clr.reset)
        print(clr.yellow..'\nTime '..clr.reset..'> '..clr.magenta..os.date()..clr.reset)
        print(clr.onmagenta ..'--------------* Bot infromation *--------------'..clr.reset)
        print(clr.yellow..'\nID '..clr.reset..'> '..clr.magenta..msg_.bot_id..clr.reset)
        print(clr.yellow..'\nName '..clr.reset..'> '..clr.magenta..msg_.bot_name..clr.reset)
        print(clr.yellow..'\nUsername '..clr.reset..'> '..clr.magenta..'@'..msg_.bot_username..clr.reset)
        print(clr.yellow..'\nNumber '..clr.reset..'> '..clr.magenta..msg_.bot_number..clr.reset)
		print(clr.onmagenta ..'\n------------* Helper infromation *-------------'..clr.reset)
		print(clr.yellow..'\nID '..clr.reset..'> '..clr.magenta..Hres.result.id..clr.reset)
    	print(clr.yellow..'\nName '..clr.reset..'> '..clr.magenta..Hres.result.first_name..clr.reset)
    	print(clr.yellow..'\nUsername '..clr.reset..'> '..clr.magenta..'@'..Hres.result.username..clr.reset.."\n-----------------------------------------------")
    end
	getMe(my_info)
end
  -------------------------------------------------
function msg_valid(msg)
    if msg.date < (os.time() - 60) and not msg.edited then
        Print('\27[36mNot valid: old msg\27[39m')
       return false
    end
  
  --[[if not redis:get("bot:lastUPDATE") then
        local chats = redis:smembers('bot:groups')
        for i=1, #chats do
          openChat(chats[i])
        end
        redis:setex("bot:lastUPDATE", 300, true) 
    end]]
	
    if not msg_.bot_id then
       get_me()
    end
    
	if not helper_started then
	    helper_started = true
	    startHelper()
	end
	
    if msg.sender_user_id == msg_.bot_id then
       Print('\27[36mNot valid: Msg from bot!\27[39m')
      return false
    end
  
    if is_channel_disabled(msg.chat_id) and not is_admin(msg) then
        Print(clr.onred.."Group was not added!"..clr.reset)
        return false
    end

    if msg.sender_user_id == 0 then
       Print('\27[36mNot valid: User ID not found!\27[39m')
      return false
    end
  
  return true
end
  -------------------------------------------------
function tdbot_update_callback(data)
    if (data._ == "updateNewMessage") then
        local msg = data.message
        if not started then
            return
        else		
            msg = pre_process_service_msg(msg)
	        if msg_valid(msg) then
                msg = pre_process_msg(msg)
                if msg then
                    match_plugins(msg)
                end
            end  
		end
    elseif (data._ == "updateMessageEdited") then
        if not started then
            return
        else
            function get_msg_contacts(extra, result, success)
                if not started then
                    return
                else
                    result = pre_process_service_msg(result)
					if msg_valid(result) then
                		result = pre_process_msg(result)
                		if result then
                 		    match_plugins(result)
              			end
           			end 
                end
            end
            getMessage(data.chat_id, data.message_id, get_msg_contacts)
	    end
    elseif (data._ == "updateOption" and data.name_ == "my_id") then
        tdcli_function ({
            ID="GetChats",
            offset_order_="9223372036854775807",
            offset_chat_id=0,
            limit_=20
        }, dl_cb, nil)
    end
end
  -------------------------------------------------
function cron_plugins()
    for name, plugin in pairs(plugins) do
        if plugin.cron ~= nil then
            plugin.cron()
        end
    end
  postpone (cron_plugins, false, 120)
end
  -------------------------------------------------
our_id = 0
now = os.time()
math.randomseed(now)
_config = load_config()
redis:select(_config.db or 0)
plugins = {}
msg_ = {}
member_ = {}
group_ = {}
get_me()
startAutoOpenChats()
load_plugins()
started = true
--[[
     **************************
     *   BlackPlus Source...  *
     *                        *
     *     By @SubProcess     *
     *                        *
     * Channel > @SubCreator  *
     **************************
	 
]]