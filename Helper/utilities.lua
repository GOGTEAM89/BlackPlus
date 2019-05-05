local misc = {}
local roles = {}

function roles.is_superadmin(user_id) --if real owner is true, the function will return true only if msg.from.id == config.admin.owner
	for i=1, #config.sudo_users do
		if tonumber(user_id) == config.sudo_users[i] then
			return true
		end
	end
	return false
end

function string:escape(only_markup)
	if not only_markup then
		-- insert word joiner
		self = self:gsub('([@#/.])(%w)', '%1\xE2\x81\xA0%2')
	end
	return self:gsub('[*_`[]', '\\%0')
end

function roles.bot_is_admin(chat_id)
	local status = api.getChatMember(chat_id, bot.id).result.status
	if not(status == 'administrator') then
		return false
	else
		return true
	end
end

function roles.is_admin(msg)
	local res = api.getChatMember(msg.chat.id, msg.from.id)
	if not res then
		return false, false
	end
	local status = res.result.status
	if status == 'creator' or status == 'administrator' then
		return true, true
	else
		return false, true
	end
end

function roles.is_admin2(chat_id, user_id)
	local res = api.getChatMember(chat_id, user_id)
	if not res then
		return false, false
	end
	local status = res.result.status
	if status == 'creator' or status == 'administrator' then
		return true, true
	else
		return false, true
	end
end

function roles.is_owner(msg)
	local status = api.getChatMember(msg.chat.id, msg.from.id).result.status
	if status == 'creator' then
		return true
	else
		return false
	end
end

function roles.is_owner2(chat_id, user_id)
	local status = api.getChatMember(chat_id, user_id).result.status
	if status == 'creator' then
		return true
	else
		return false
	end
end

function vardump(value)
  print(serpent.block(value, {comment=false}))
end

function misc.get_media_type(msg)
	if msg.photo then
		return 'image'
	elseif msg.video then
		return 'video'
	elseif msg.audio then
		return 'audio'
	elseif msg.voice then
		return 'voice'
	elseif msg.document then
		if msg.document.mime_type == 'video/mp4' then
			return 'gif'
		else
			return 'file'
		end
	elseif msg.sticker then
		return 'sticker'
	elseif msg.contact then
		return 'contact'
	end
	return false
end

function misc.get_media_id(msg)
	if msg.photo then
		if msg.photo[3] then
			return msg.photo[3].file_id, 'photo'
		else
			if msg.photo[2] then
				return msg.photo[2].file_id, 'photo'
			else
				if msg.photo[1] then
					return msg.photo[1].file_id, 'photo'
				else
					return msg.photo.file_id, 'photo'
				end
			end
		end
	elseif msg.document then
		return msg.document.file_id
	elseif msg.video then
		return msg.video.file_id, 'video'
	elseif msg.audio then
		return msg.audio.file_id
	elseif msg.voice then
		return msg.voice.file_id, 'voice'
	elseif msg.sticker then
		return msg.sticker.file_id
	else
		return false, 'The message has not a media file_id'
	end
end

function misc.log_error(method, code, extras)
	if not method or not code then return end
	
	local ignored_errors = {403, 429, 110, 111, 116, 131}
	
	for _, ignored_code in pairs(ignored_errors) do
		if tonumber(code) == tonumber(ignored_code) then return end
	end
	
	local text = 'Type: #badrequest\nCode: #n'..code
	
	if extras then
		if next(extras) then
			for i, extra in pairs(extras) do
				text = text..'\n#more'..i..': '..extra
			end
		else
			text = text..'\n#more: empty'
		end
	else
		text = text..'\n#more: nil'
	end
	
	api.sendLog(text)
end

function misc.clone_table(t)
  local new_t = {}
  local i, v = next(t, nil)
  while i do
    new_t[i] = v
    i, v = next(t, i)
  end
  return new_t
end

function misc.getAdminlist(chat_id)
	local list, code = api.getChatAdministrators(chat_id)
	if not list then
		if code == 107 then
			return false, code
		else
			return false, false
		end
	end
	local creator = ''
	local adminlist = ''
	local count = 1
	for i,admin in pairs(list.result) do
		local name
		if admin.status == 'administrator' then
			adminlist = adminlist.."\n["..(admin.user.username or admin.user.first_name).."](https://telegram.me/"..(admin.user.username or '')..")"
			count = count + 1
		elseif admin.status == 'creator' then
			creator = adminlist..'['..(admin.user.username or admin.user.first_name)..'](https://telegram.me/'..(admin.user.username or '')..')\n'
			end
		end
	if adminlist == '' then adminlist = '`Err #404`' end
	if creator == '' then creator = '`Err #404`' end
	return creator, adminlist
end

function misc.sendStartMe(msg)
    local keyboard = {inline_keyboard = {{{text = _("Start me"), url = 'https://telegram.me/'..bot.username}}}}
	api.sendKeyboard(msg.chat.id, _("_Please message me first so I can message you_"), keyboard, true)
end

return misc, roles
