local saga_status_ok, saga = pcall(require, "lspsaga")

if not saga_status_ok then
	return
end

saga.setup({
	diagnostic = {
		on_insert = false
	}
})
