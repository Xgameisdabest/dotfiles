return{
	"mbbill/undotree",
	init = function()
		vim.g.undotree_CustomUndotreeCmd  = 'rightbelow vertical 30 new'
		vim.g.undotree_CustomDiffpanelCmd = 'belowright 10 new'
		vim.o.equalalways                 = false
	end,
}
