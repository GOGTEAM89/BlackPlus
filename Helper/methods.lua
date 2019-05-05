local BASE_URL = 'https://api.telegram.org/bot' .. config.helper.token
HTTPS = require('ssl.https')
local api = {}

local curl_context = curl.easy{verbose = false}

local function performRequest(url)
	local data = {}
	
	-- if multithreading is made, this request must be in critical section
	local c = curl_context:setopt_url(url)
		:setopt_writefunction(table.insert, data)
		:perform()

	return table.concat(data), c:getinfo_response_code()
end

local function sendRequest(url)
	local dat, code = performRequest(url)
	local tab = JSON.decode(dat)

	if not tab then
	end

	if code ~= 200 then
		return false, code, false
	end
	
	if not tab.ok then
		return fals
	end
	
	return tab

end

function api.getMe()

	local url = BASE_URL .. '/getMe'

	return sendRequest(url)

end

function api.getUpdates(offset)

	local url = BASE_URL .. '/getUpdates?timeout=20'

	if offset then
		url = url .. '&offset=' .. offset
	end

	return sendRequest(url)

end

function api.unbanChatMember(chat_id, user_id)
	
	local url = BASE_URL .. '/unbanChatMember?chat_id=' .. chat_id .. '&user_id=' .. user_id

	return sendRequest(url)
end

function api.kickChatMember(chat_id, user_id)
	
	local url = BASE_URL .. '/kickChatMember?chat_id=' .. chat_id .. '&user_id=' .. user_id
	
	local success, code, description = sendRequest(url)
	if success then
		db:srem(string.format('chat:%d:members', chat_id), user_id)
	end

	return success, code, description
end

local function code2text(code)
	--the default error description can't be sent as output, so a translation is needed
	if code == 101 or code == 105 or code == 107 then
		return ("I'm not an admin, I can't kick people")
	elseif code == 102 or code == 104 then
		return ("I can't kick or ban an admin")
	elseif code == 103 then
		return ("There is no need to unban in a normal group")
	elseif code == 106 or code == 134 then
		return ("This user is not a chat member")
	elseif code == 7 then
		return false
	end
	return false
end

function api.banUser(chat_id, user_id)
	
	local res, code = api.kickChatMember(chat_id, user_id) --try to kick. "code" is already specific
	
	if res then --if the user has been kicked, then...
		return res --return res and not the text
	else ---else, the user haven't been kicked
		local text = code2text(code)
		return res, text --return the motivation too
	end
end

function api.kickUser(chat_id, user_id)
	
	local res, code = api.kickChatMember(chat_id, user_id) --try to kick
	
	if res then --if the user has been kicked, then...
		--unban
		api.unbanChatMember(chat_id, user_id)
		api.unbanChatMember(chat_id, user_id)
		api.unbanChatMember(chat_id, user_id)
		return res
	else
		local motivation = code2text(code)
		return res, motivation
	end
end

function api.unbanUser(chat_id, user_id)
	
	local res, code = api.unbanChatMember(chat_id, user_id)
	return true
end

function api.getChat(chat_id)
	
	local url = BASE_URL .. '/getChat?chat_id=' .. chat_id
	
	return sendRequest(url)
	
end

function api.getChatAdministrators(chat_id)
	
	local url = BASE_URL .. '/getChatAdministrators?chat_id=' .. chat_id
	
	local res, code, desc = sendRequest(url)
	
	if not res and code then --if the request failed and a code is returned (not 403 and 429)
		misc.log_error('getChatAdministrators', code, nil, desc)
	end
	
	return res, code
	
end

function api.getChatMembersCount(chat_id)
	
	local url = BASE_URL .. '/getChatMembersCount?chat_id=' .. chat_id
	
	return sendRequest(url)
	
end

function api.getChatMember(chat_id, user_id)
	
	local url = BASE_URL .. '/getChatMember?chat_id=' .. chat_id .. '&user_id=' .. user_id
	
	local res, code, desc = sendRequest(url)
	
	if not res and code then --if the request failed and a code is returned (not 403 and 429)
		misc.log_error('getChatMember', code, nil, desc)
	end
	
	return res, code
	
end

function api.getUserProfilePhotos(user_id, offset, limit)
	
	local url = BASE_URL .. '/getUserProfilePhotos?user_id=' .. user_id
	
	if offset then
	  url = url..'&offset='..offset
	end
	
	if limit then
	  url = url..'&limit='..limit
	end
	
	local res, code, desc = sendRequest(url)
	
	return res, code
	
end

function api.leaveChat(chat_id)
	
	local url = BASE_URL .. '/leaveChat?chat_id=' .. chat_id
	
	local res, code = sendRequest(url)
	
	if res then
		db:srem(string.format('chat:%d:members', chat_id), bot.id)
	end
	
	if not res and code then --if the request failed and a code is returned (not 403 and 429)
		misc.log_error('leaveChat', code)
	end
	
	return res, code
	
end

function api.sendKeyboard(chat_id, text, keyboard, markdown, reply_id)
	
	local url = BASE_URL .. '/sendMessage?chat_id=' .. chat_id
	
	if markdown then
		url = url .. '&parse_mode=Markdown'
	end
	
	if reply_id then
		url = url .. '&reply_to_message_id='..reply_id
	end
	
	url = url..'&text='..URL.escape(text)
	
	url = url..'&disable_web_page_preview=true'
	
	url = url..'&reply_markup='..URL.escape(JSON.encode(keyboard))
		
	local res, code, desc = sendRequest(url)
	
	if not res and code then --if the request failed and a code is returned (not 403 and 429)
		misc.log_error('sendKeyboard', code, {text}, desc)
	end
	
	return res, code --return false, and the code

end

function api.sendInlinemd(inline_query_id, results, cache_time, is_personal, next_offset)

	local url = BASE_URL .. '/answerInlineQuery?inline_query_id=' .. inline_query_id ..'&results=' .. URL.escape(JSON.encode(results))
	
		url = url .. '&parse_mode=Markdown'
		
	if cache_time then
	
	url = url .. '&cache_time=' .. cache_time
	
	end
	
	if is_personal then
	
	url = url .. '&is_personal=' .. is_personal
	
	end
	
	if next_offset then
	
	url = url .. '&next_offset=' .. next_offset
	
	end
	
	return sendRequest(url)
	
end

function api.send_key(chat_id, text, keyboard, resize, mark, one_time, selective)
	response = {}
	response.keyboard = keyboard
	response.resize_keyboard = resize
	response.one_time_keyboard = one_time
	response.selective = selective
	responseString = JSON.encode(response)
	if not mark then
		sended = BASE_URL .. "/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&disable_web_page_preview=true&reply_markup="..URL.escape(responseString)
	else
		sended = BASE_URL .. "/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(responseString)
	end
	dat, res = HTTPS.request(sended)
	tab = JSON.decode(dat)
	return tab
end

function api.sendsscap(chat_id, text, keyboard, markdown)
	
	local url = BASE_URL .. '/sendMessage?chat_id=' .. chat_id
	
	if markdown then
		url = url .. '&parse_mode=Markdown'
	end
	
	url = url..'&text='..URL.escape(text)
	
	url = url..'&disable_web_page_preview=true'
	
	url = url..'&reply_markup='..URL.escape(JSON.encode({keyboard}))
	
	local res, code, desc = sendRequest(url)
	
	if not res and code then --if the request failed and a code is returned (not 403 and 429)
		misc.log_error('sendKeyboard', code, {text}, desc)
	end
	
	return res, code --return false, and the code

end

function api.sendMessage(chat_id, text, use_markdown, reply_to_message_id, send_sound)
	--print(text)
	
	local url = BASE_URL .. '/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text)

	url = url .. '&disable_web_page_preview=true'

	if reply_to_message_id then
		url = url .. '&reply_to_message_id=' .. reply_to_message_id
	end
	
	if use_markdown then
		url = url .. '&parse_mode=Markdown'
	end
	
	if not send_sound then
		url = url..'&disable_notification=true'--messages are silent by default
	end
	
	local res, code, desc = sendRequest(url)
	
	if not res and code then --if the request failed and a code is returned (not 403 and 429)
		misc.log_error('sendMessage', code, {text}, desc)
	end
	
	return res, code --return false, and the code

end

function api.sendMessagehtml(chat_id, text, use_markdown, reply_to_message_id, send_sound)
	--print(text)
	
	local url = BASE_URL .. '/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text)

	url = url .. '&disable_web_page_preview=true'

	if reply_to_message_id then
		url = url .. '&reply_to_message_id=' .. reply_to_message_id
	end
	
	if use_markdown then
		url = url .. '&parse_mode=HTML'
	end
	
	if not send_sound then
		url = url..'&disable_notification=true'--messages are silent by default
	end
	
	local res, code, desc = sendRequest(url)
	
	if not res and code then --if the request failed and a code is returned (not 403 and 429)
		misc.log_error('sendMessage', code, {text}, desc)
	end
	
	return res, code --return false, and the code

end 

function api.sendReplyhtml(msg, text, markd, send_sound)
	return api.sendMessage(msg.chat.id, text, markd, msg.message_id, send_sound)
end

function api.sendReply(msg, text, markd, send_sound)
	return api.sendMessage(msg.chat.id, text, markd, msg.message_id, send_sound)
end


function api.editMessageText(chat_id, message_id, text, keyboard, markdown, preview)
	
	local url = BASE_URL 
	
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
	
	if not res and code then --if the request failed and a code is returned (not 403 and 429)
		misc.log_error('editMessageText', code, {text}, desc)
	end
	
	return res, code

end

function api.editMarkup(chat_id, message_id, reply_markup)
	
	local url = BASE_URL .. '/editMessageReplyMarkup?chat_id=' .. chat_id ..
		'&message_id='..message_id..
		'&reply_markup='..URL.escape(JSON.encode(reply_markup))
	
	return sendRequest(url)

end

function api.sendChatAction(chat_id, action)
 -- Support actions are typing, upload_photo, record_video, upload_video, record_audio, upload_audio, upload_document, find_location

	local url = BASE_URL .. '/sendChatAction?chat_id=' .. chat_id .. '&action=' .. action
	return sendRequest(url)

end

function api.rsendMessage(chat_id, text, use_markdown, reply_to_message_id, send_sound,keyboard)
		--print(text)
	local url = BASE_URL .. '/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text)

	url = url .. '&disable_web_page_preview=true'

	if reply_to_message_id then
		url = url .. '&reply_to_message_id=' .. reply_to_message_id
	end
	
	if use_markdown then
		url = url .. '&parse_mode=Markdown'
	end
	
	if not send_sound then
		url = url..'&disable_notification=true'--messages are silent by default
	end
	if keyboard then
	url = url..'&reply_markup='..JSON:encode(keyboard)
	end
	local res, code = sendRequest(url)
	return res, code --return false, and the code
end

function api.sendMsg(chat_id, text, use_markdown, reply_to_message_id, send_sound,key_board)
	local text_max = 4096
    local text_len = string.len(text)
    local num_msg = math.ceil(text_len / text_max)
    if num_msg <= 1 then
    return api.rsendMessage(chat_id, text, use_markdown, reply_to_message_id, send_sound,key_board)
    else
    local my_text = string.sub(text, 1, text_max)
    api.rsendMessage(chat_id, my_text, use_markdown, reply_to_message_id, send_sound,key_board)
    local rest = string.sub(text, text_max, text_len)
    return api.sendMsg(chat_id, rest, use_markdown, reply_to_message_id, send_sound,key_board)
end
end

function api.answerCallbackQuery(callback_query_id, text, show_alert)
	
	local url = BASE_URL .. '/answerCallbackQuery?callback_query_id=' .. callback_query_id .. '&text=' .. URL.escape(text)
	
	if show_alert then
		url = url..'&show_alert=true'
	end
	
	return sendRequest(url)
	
end

function api.sendLocation(chat_id, latitude, longitude, reply_to_message_id)

	local url = BASE_URL .. '/sendLocation?chat_id=' .. chat_id .. '&latitude=' .. latitude .. '&longitude=' .. longitude

	if reply_to_message_id then
		url = url .. '&reply_to_message_id=' .. reply_to_message_id
	end

	return sendRequest(url)

end

function api.forwardMessage(chat_id, from_chat_id, message_id)

	local url = BASE_URL .. '/forwardMessage?chat_id=' .. chat_id .. '&from_chat_id=' .. from_chat_id .. '&message_id=' .. message_id

	local res, code, desc = sendRequest(url)
	
	if not res and code then --if the request failed and a code is returned (not 403 and 429)
		misc.log_error('forwardMessage', code, nil, desc)
	end
	
	return res, code
	
end

function api.getFile(file_id)
	
	local url = BASE_URL .. '/getFile?file_id='..file_id
	
	return sendRequest(url)
	
end

----------------------------By Id-----------------------------------------

function api.sendMediaId(chat_id, file_id, media, reply_to_message_id, caption, markup)
	local url = BASE_URL
	if media == 'voice' then
		url = url..'/sendVoice?chat_id='..chat_id..'&voice='
	elseif media == 'video' then
		url = url..'/sendVideo?chat_id='..chat_id..'&video='
	elseif media == 'photo' then
		url = url..'/sendPhoto?chat_id='..chat_id..'&photo='
	else
		return false, 'Media passed is not voice/video/photo'
	end
	
	url = url..file_id
	
	if reply_to_message_id then
		url = url..'&reply_to_message_id='..reply_to_message_id
	end
	
	if caption then
		url = url..'&caption='..caption
	end
	
	if markup then
		url = url..'&reply_markup='..URL.escape(JSON.encode(markup))
	end

	return sendRequest(url)
end

function api.sendPhotoId(chat_id, file_id, reply_to_message_id, caption)
	
	local url = BASE_URL .. '/sendPhoto?chat_id=' .. chat_id .. '&photo=' .. file_id
	
	if reply_to_message_id then
		url = url..'&reply_to_message_id='..reply_to_message_id
	end
	
    if caption then
		url = url..'&caption='..caption
	end
	
	return sendRequest(url)
	
end

function api.sendDocumentId(chat_id, file_id, reply_to_message_id, caption, markup)
	
	local url = BASE_URL .. '/sendDocument?chat_id=' .. chat_id .. '&document=' .. file_id
	
	if reply_to_message_id then
		url = url..'&reply_to_message_id='..reply_to_message_id
	end

	if caption then
		url = url..'&caption='..caption
	end
	
	if markup then
		url = url..'&reply_markup='..URL.escape(JSON.encode(markup))
	end
	
	return sendRequest(url)
	
end

function api.downloadFile(file_patch, download_path)

  local download_file_path = download_path
  
  local download_file = io.open(download_file_path, "w")
  
    HTTPS.request{
	
      url = file_patch,
	  
	  sink = ltn12.sink.file(download_file)
	  
    }
	
    return download_file_path
	
end

function api.get_file_path(file_id)

local x = HTTPS.request(BASE_URL.."/getFile?file_id="..file_id)

local y = JSON.decode(x)

local url = "https://api.telegram.org/file/bot"..config.helper.token.."/"..y..".jpg"

return url

end
----------------------------To curl--------------------------------------------

local function curlRequest(curl_command)
 -- Use at your own risk. Will not check for success.

	io.popen(curl_command)

end

function api.sendPhoto(chat_id, photo, caption, reply_to_message_id)

	local url = BASE_URL .. '/sendPhoto'

	local curl_command = 'curl "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "photo=@' .. photo .. '"'

	if reply_to_message_id then
		curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
	end

	if caption then
		curl_command = curl_command .. ' -F "caption=' .. caption .. '"'
	end

	return curlRequest(curl_command)

end

function api.sendDocument(chat_id, document, reply_to_message_id, caption)

	local url = BASE_URL .. '/sendDocument'

	local curl_command = 'curl "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "document=@' .. document .. '"'

	if reply_to_message_id then
		curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
	end
	
	if caption then
		curl_command = curl_command .. ' -F "caption=' .. caption .. '"'
	end
	
	return curlRequest(curl_command)

end

function api.sendSticker(chat_id, sticker, reply_to_message_id)

	local url = BASE_URL .. '/sendSticker'

	local curl_command = 'curl "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "sticker=@' .. sticker .. '"'

	if reply_to_message_id then
		curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
	end

	return curlRequest(curl_command)

end

function api.sendStickerId(chat_id, file_id, reply_to_message_id, markup)
	
	local url = BASE_URL .. '/sendSticker?chat_id=' .. chat_id .. '&sticker=' .. file_id
	
	if reply_to_message_id then
		url = url..'&reply_to_message_id='..reply_to_message_id
	end

	if markup then
		url = url..'&reply_markup='..URL.escape(JSON.encode(markup))
	end
	
	return sendRequest(url)
	
end

function api.sendAudio(chat_id, audio, reply_to_message_id, duration, performer, title)

	local url = BASE_URL .. '/sendAudio'

	local curl_command = 'curl "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "audio=@' .. audio .. '"'

	if reply_to_message_id then
		curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
	end

	if duration then
		curl_command = curl_command .. ' -F "duration=' .. duration .. '"'
	end

	if performer then
		curl_command = curl_command .. ' -F "performer=' .. performer .. '"'
	end

	if title then
		curl_command = curl_command .. ' -F "title=' .. title .. '"'
	end

	return curlRequest(curl_command)

end

function api.sendVideo(chat_id, video, reply_to_message_id, duration, performer, title)

	local url = BASE_URL .. '/sendVideo'

	local curl_command = 'curl "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "video=@' .. video .. '"'

	if reply_to_message_id then
		curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
	end

	if caption then
		curl_command = curl_command .. ' -F "caption=' .. caption .. '"'
	end

	if duration then
		curl_command = curl_command .. ' -F "duration=' .. duration .. '"'
	end

	return curlRequest(curl_command)

end

function api.sendVoice(chat_id, voice, reply_to_message_id)

	local url = BASE_URL .. '/sendVoice'

	local curl_command = 'curl "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "voice=@' .. voice .. '"'

	if reply_to_message_id then
		curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
	end

	if duration then
		curl_command = curl_command .. ' -F "duration=' .. duration .. '"'
	end

	return curlRequest(curl_command)

end

function api.sendAdmin(text, markdown)
	return api.sendMessage(config.log.admin, text, markdown)
end

function api.sendLog(text, markdown)
	return api.sendMessage(config.log.chat or config.log.admin, text, markdown)
end

return api
