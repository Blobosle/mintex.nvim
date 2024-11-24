vim.api.nvim_create_user_command('Latex', function()
    local file_dir = vim.fn.expand('%:p:h')
    vim.cmd('cd ' .. vim.fn.fnameescape(file_dir))

    local file_name = vim.fn.expand('%:t:r')
    local tex_file = file_name .. '.tex'
    local pdf_file = file_name .. '.pdf'

    vim.fn.system({'rm', '-f', pdf_file})

    for _ = 1, 3 do
        vim.fn.system({'pdflatex', '-interaction=batchmode', tex_file})
    end

    vim.cmd('OpenPDF')

    vim.cmd('cd -')
end, {})

vim.api.nvim_create_user_command('OpenPDF', function()
    local pdf_file = vim.fn.expand('%:t:r') .. '.pdf'
    local sysname = vim.loop.os_uname().sysname
    local open_cmd = 'open'

    if sysname == 'Linux' then
        open_cmd = 'xdg-open'
    elseif sysname == 'Windows_NT' then
        open_cmd = 'start'
    end

    vim.fn.jobstart({open_cmd, pdf_file}, {detach = true})
end, {})
