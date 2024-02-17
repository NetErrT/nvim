local notify = require("notify")

local log = vim.log
local lsp = vim.lsp

notify.setup({
	render = "compact",
	stages = "static",
})

vim.notify = notify

local data_notifications = {}

local function get_data(id)
	if not data_notifications[id] then
		data_notifications[id] = {}
	end

	return data_notifications[id]
end

local function format_message(percentage, message)
	return (percentage and percentage .. "% " or "") .. (message or "")
end

local function format_title(label, title)
	return label .. (#title > 0 and ": " .. title or "")
end

lsp.handlers["$/progress"] = function(_, result, context)
	local client_id = context.client_id
	local value = result.value
	local label = lsp.get_client_by_id(client_id).name
	local data = get_data(client_id .. result.token)

	if value.kind == "begin" then
		data.notification = notify(format_message(value.percentage, value.message), log.levels.INFO, {
			title = format_title(label, value.title),
			timeout = false,
			hide_from_history = false,
		})
	elseif value.kind == "report" and data then
		data.notification = notify(format_message(value.percentage, value.message), log.levels.INFO, {
			replace = data.notification,
			hide_from_history = false,
			timeout = false,
		})
	elseif value.kind == "end" and data then
		data.notification = notify(value.message and format_message(nil, value.message) or "Completed", log.levels.INFO, {
			replace = data.notification,
			timeout = 3000,
		})
	end
end

local severity = {
	log.levels.ERROR,
	log.levels.WARN,
	log.levels.INFO,
	log.levels.INFO,
}

lsp.handlers["window/showMessage"] = function(_, method, params, _)
	notify(method.message, severity[params.type])
end
